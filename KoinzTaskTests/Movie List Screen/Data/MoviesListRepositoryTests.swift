//
//  MoviesListRepositoryTests.swift
//  KoinzTaskTests
//
//  Created by Ramy Sabry on 20/05/2022.
//

import XCTest
@testable import Koinz_Task
import RxTest
import RxSwift

class MoviesListRepositoryTests: XCTestCase {
    private var sut: MoviesListRepository!
    private var disboseBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disboseBag = DisposeBag()
        sut = MoviesListRepository(
            apiService: MockValidApiService(),
            storage: MockValidMoviesStorage(),
            reachability: MockConnectedReachability(),
            disposeBag: disboseBag
        )
    }
    
    override func tearDown() {
        sut = nil
        disboseBag = nil
        super.tearDown()
    }
    
    func testSUT_fetchingMoviesFromRemote_successResponse() {
        // Given
        let exp = expectation(description: "Fetching movies from remote")
        
        let mockValidApiService = MockValidApiService()
        mockValidApiService.fileName = "getTopRatedMovies_validResponse"
        
        sut = MoviesListRepository(
            apiService: mockValidApiService,
            storage: MockValidMoviesStorage(),
            reachability: MockConnectedReachability(),
            disposeBag: disboseBag
        )
        
        // When
        sut.fetchTopRatedMovies(using: 1)
            .subscribe(onNext: { result in
                
                // Then
                switch result {
                case .success(let response):
                    XCTAssertFalse(response.results.isNil)
                    exp.fulfill()
                    
                case .failure(let error):
                    XCTAssertNil(error)
                    exp.fulfill()
                }
            })
            .disposed(by: disboseBag)
        
        waitForExpectations(timeout: 1)
    }
    
    func testSUT_fetchingMoviesFromRemote_failureResponse() {
        // Given
        let exp = expectation(description: "Fetching movies from remote")
        
        let mockInValidApiService = MockInValidApiService()
        
        sut = MoviesListRepository(
            apiService: mockInValidApiService,
            storage: MockValidMoviesStorage(),
            reachability: MockConnectedReachability(),
            disposeBag: disboseBag
        )
        
        // When
        sut.fetchTopRatedMovies(using: 1)
            .subscribe(onNext: { result in
                
                // Then
                switch result {
                case .success(let response):
                    XCTAssertTrue(response.results.isNil)
                    exp.fulfill()
                    
                case .failure(let error):
                    XCTAssertNotNil(error)
                    exp.fulfill()
                }
            })
            .disposed(by: disboseBag)
        
        waitForExpectations(timeout: 1)
    }
    
    func testSUT_fetchingMoviesFromCache_successResponse() {
        // Given
        let exp = expectation(description: "Fetching movies from remote")
        let notConnectedReachability = MockNotConnectedReachability()
        
        sut = MoviesListRepository(
            apiService: MockValidApiService(),
            storage: MockValidMoviesStorage(),
            reachability: notConnectedReachability,
            disposeBag: disboseBag
        )
        
        // When
        sut.fetchTopRatedMovies(using: 1)
            .subscribe(onNext: { result in
                
                // Then
                switch result {
                case .success(let response):
                    XCTAssertFalse(response.results.isNil)
                    exp.fulfill()
                    
                case .failure(let error):
                    XCTAssertNil(error)
                    exp.fulfill()
                }
            })
            .disposed(by: disboseBag)
        
        waitForExpectations(timeout: 1)
    }
    
    func testSUT_fetchingMoviesFromCache_failureResponse() {
        // Given
        let exp = expectation(description: "Fetching movies from remote")
        let invalidStorage = MockInValidMoviesStorage()
        let notConnectedReachability = MockNotConnectedReachability()
        
        sut = MoviesListRepository(
            apiService: MockValidApiService(),
            storage: invalidStorage,
            reachability: notConnectedReachability,
            disposeBag: disboseBag
        )
        
        // When
        sut.fetchTopRatedMovies(using: 1)
            .subscribe(onNext: { result in
                
                // Then
                switch result {
                case .success(let response):
                    XCTAssertTrue(response.results.isNil)
                    exp.fulfill()
                    
                case .failure(let error):
                    XCTAssertNotNil(error)
                    exp.fulfill()
                }
            })
            .disposed(by: disboseBag)
        
        waitForExpectations(timeout: 1)
    }
}
