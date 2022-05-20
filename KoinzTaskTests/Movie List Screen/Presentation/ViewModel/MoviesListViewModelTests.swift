//
//  MoviesListViewModelTests.swift
//  KoinzTaskTests
//
//  Created by Ramy Sabry on 20/05/2022.
//

import XCTest
@testable import Koinz_Task
import RxSwift

class MoviesListViewModelTests: XCTestCase {
    private var sut: MoviesListViewModel!
    private var disposeBag: DisposeBag!
    
    override func setUp() {
        super.setUp()
        disposeBag = DisposeBag()
        sut = MoviesListViewModel(moviesListRepository: MockValidMoviesListRepository())
    }
    
    override func tearDown() {
        sut = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func testSUT_whenCallingFetchMovies_dataShouldBeReturned() {
        // Given
        let exp = expectation(description: "Fetching movies description")
        sut = MoviesListViewModel(moviesListRepository: MockValidMoviesListRepository())
        
        // When
        sut.fetchMovies()
        
        // Then
        sut.moviesSubject
            .subscribe { movies in
                exp.fulfill()
                XCTAssertFalse(movies.isEmpty)
            } onError: { error in
                XCTAssertNil(error)
                exp.fulfill()
            }
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 1)
    }
    
    func testSUT_whenCallingFetchMovies_returnFailure() {
        // Given
        let exp = expectation(description: "Fetching movies description")
        sut = MoviesListViewModel(moviesListRepository: MockInValidMoviesListRepository())
        
        // When
        sut.fetchMovies()
        
        // Then
        sut.moviesSubject
            .subscribe(onNext: { movies in
                XCTAssertTrue(movies.isEmpty)
                exp.fulfill()
            })
            .disposed(by: disposeBag)
        
        waitForExpectations(timeout: 10)
        
        
    }
    
    func testSUT_whenCallingIsWideCell_onEveryFiveElements_returnTrue() {
        // Given
        let indexPath = IndexPath(row: 15, section: 0)
        
        // When
        let isWideCell: Bool = sut.isWideCell(forCell: indexPath)
        
        // Then
        XCTAssertTrue(isWideCell)
    }
    
    func testSUT_whenCallingIsWideCell_onNotFiveElements_returnFalse() {
        // Given
        let indexPath = IndexPath(row: 8, section: 0)
        
        // When
        let isWideCell: Bool = sut.isWideCell(forCell: indexPath)
        
        // Then
        XCTAssertFalse(isWideCell)
    }
}
