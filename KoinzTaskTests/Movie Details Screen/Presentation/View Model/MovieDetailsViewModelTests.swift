//
//  MovieDetailsViewModelTests.swift
//  KoinzTaskTests
//
//  Created by Ramy Sabry on 21/05/2022.
//

import XCTest
@testable import Koinz_Task

class MovieDetailsViewModelTests: XCTestCase {
    private var sut: MovieDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailsViewModel(posterPath: MockData.posterPath)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSUT_whenCallingGetMoviesURl_urlShouldBeValid() {
        // Given
        let posterPath: String = MockData.posterPath
        let expectedValidURL: String = NetworkConstants.imageURL + ImageSize.original.rawValue + posterPath
        sut = MovieDetailsViewModel(posterPath: posterPath)
        
        // When
        let imageURL = sut.getMovieImageURL()
        
        // Then
        XCTAssertEqual(imageURL, expectedValidURL)
    }
    
    func testSUT_whenCallingGetMoviesURl_withInvalidPosterPath_urlShouldBeEmpty() {
        // Given
        sut = MovieDetailsViewModel(posterPath: nil)
        
        // When
        let imageURL = sut.getMovieImageURL()
        
        // Then
        XCTAssertTrue(imageURL.isEmpty)
    }
}
