//
//  MoviesListViewTests.swift
//  KoinzTaskTests
//
//  Created by Ramy Sabry on 20/05/2022.
//

import XCTest
@testable import Koinz_Task
import SnapshotTesting

class MoviesListViewTests: XCTestCase {
    private var sut: UIViewController!
    
    override func setUp() {
        super.setUp()
        sut = MoviesListViewController()
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
