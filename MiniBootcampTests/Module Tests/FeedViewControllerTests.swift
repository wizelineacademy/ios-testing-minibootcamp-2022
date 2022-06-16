//
//  FeedViewControllerTests.swift
//  Mini bootcampTests
//
//  Created by Abner Castro on 07/04/22.
//

import XCTest
@testable import MiniBootcamp

class FeedViewControllerTests: XCTestCase {
    
    func test_vc_backgroundIsSystemBackground() {
      // Given
        let sut = FeedViewController()
      // Then
        XCTAssertNotNil(sut.view?.backgroundColor)
        XCTAssertEqual(sut.view?.backgroundColor, .white)
    }

}
