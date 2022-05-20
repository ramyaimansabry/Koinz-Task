//
//  MovieDetailsViewTests.swift
//  KoinzTaskTests
//
//  Created by Ramy Sabry on 21/05/2022.
//

import XCTest
@testable import Koinz_Task
import SnapshotTesting

class MovieDetailsViewTests: XCTestCase {
    private var sut: UIViewController!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailsViewViewController(posterPath: MockData.posterPath)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSUT_koko() {
        XCTAssertTrue(true)
    }
    
    func testSUT_whenInit_showDefaultAppearance() {
        assertSnapshot(matching: sut, as: .image)
    }
}
