//
//  MainTabBarTest.swift
//  MiniBootcampTests
//
//  Created by Javier Cueto on 03/07/22.
//

import XCTest
@testable import MiniBootcamp

class MainTabBarTest: XCTestCase {
    
    var sut: MainTabBarController!

    override func setUp() {
        sut = MainTabBarController()
    }
    
    func testTabBarHasThreeViewControllers() {
        XCTAssertEqual(sut.viewControllers?.count, 2)
    }

    override func tearDown() {
        sut = nil
    }

}
