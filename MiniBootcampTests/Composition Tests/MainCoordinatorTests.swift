//
//  MainCoordinatorTests.swift
//  Mini bootcampTests
//
//  Created by Abner Castro on 07/04/22.
//

import XCTest
@testable import MiniBootcamp

class MainCoordinatorTests: XCTestCase {

  func test_empty_rootVCDoesNotHaveRootVC() {
    let sut = makeSUT(nv: UINavigationController())
    XCTAssertEqual(sut.rootViewController.viewControllers.count, 0)
  }

  func test_whenStarts_rootVCHasRootVC() {
    let sut = makeSUT(nv: UINavigationController())
    sut.start()
    XCTAssertEqual(sut.rootViewController.viewControllers.count, 1)
  }

  func test_whenStarts_rootVCIsFeedViewController() {
    // Given
    let sut = makeSUT(nv: UINavigationController(), factory: StubFactory())
    // When
    sut.start()
    let feedVC = sut.rootViewController.viewControllers[0] as? FeedViewController
    // Then
    XCTAssertNotNil(feedVC)
  }

  func test_composeTweet_launchesViewController() {
    // Given
    let sut = makeSUT(nv: UINavigationController(), factory: StubFactory())
    // When
    sut.composeTweet()
    let composeTweetVC = sut.rootViewController.viewControllers[0] as? ComposeTweetViewController
    // Then
    XCTAssertNotNil(composeTweetVC)
  }

  func test_getUserProfile_launchesUserProfileViewController() {
    // Given
    let sut = makeSUT(nv: UINavigationController(), factory: StubFactory())
    // When
    sut.getUserProfile()
    let userProfileVC = sut.rootViewController.viewControllers[0] as? UserProfileViewController
    // Then
    XCTAssertNotNil(userProfileVC)
  }

  // MARK: - Helper Methods
  private func makeSUT(nv: UINavigationController = UINavigationController(), factory: ViewControllerFactory = StubFactory()) -> MainCoordinator {
    MainCoordinator(rootViewController: nv, viewControllerFactory: factory)
  }
}

// MARK: - Stubs
private class StubFactory: ViewControllerFactory {
  func feedViewController() -> UIViewController {
    return FeedViewController()
  }

  func composeTweetViewController() -> UIViewController {
    return ComposeTweetViewController()
  }

  func getUserProfile() -> UIViewController {
    return UserProfileViewController()
  }
}
