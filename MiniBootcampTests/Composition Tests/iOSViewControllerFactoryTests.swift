//
//  iOSViewControllerFactoryTests.swift
//  Mini bootcampTests
//
//  Created by Abner Castro on 07/04/22.
//

import XCTest
@testable import MiniBootcamp

class iOSViewControllerFactoryTests: XCTestCase {

  var sut: iOSViewControllerFactory!

  override func setUp() {
    super.setUp()
    sut = iOSViewControllerFactory()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func test_feedViewController_isFeedViewControllerType() {
    // Given
    let feedVC = sut.feedViewController() as? FeedViewController
    // Then
    XCTAssertNotNil(feedVC)

  }

  func test_composeTweetViewController_isComposeViewControllerType() {
    // Given
    let composeTweetVC = sut.composeTweetViewController() as? ComposeTweetViewController

    // Then
    XCTAssertNotNil(composeTweetVC)
  }
}
