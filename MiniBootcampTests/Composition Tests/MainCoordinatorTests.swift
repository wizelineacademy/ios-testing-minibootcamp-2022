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
        let sut = makeSUT(nv: UINavigationController(), factory: StubFactory())
        sut.start()
        let feedVC = sut.rootViewController.viewControllers[0] as? FeedViewController
        XCTAssertNotNil(feedVC)
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
}
