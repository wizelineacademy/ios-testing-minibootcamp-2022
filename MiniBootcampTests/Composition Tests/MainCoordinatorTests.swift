//
//  MainCoordinatorTests.swift
//  Mini bootcampTests
//
//  Created by Abner Castro on 07/04/22.
//

import XCTest
@testable import MiniBootcamp

class MainCoordinatorTests: XCTestCase {
    
    var sut_tweetvm: TweetViewModel?
    var sut_uservm: UserViewModel?
    lazy var bundle = Bundle(for: self.classForCoder)

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
    func test_whenShowDetailVCIsDetailViewController() {
        
        
       
        let sut = makeSUT(nv: UINavigationController(), factory: StubFactory())
        sut.start()
        sut.showDetail(tweetViewModel:self.sut_tweetvm! , userViewModel: self.sut_uservm!, userImage: UIImage(named: "gato")!)
        let detailVC = sut.rootViewController.topViewController as! DetailViewController
        
        XCTAssertNotNil(detailVC)
    }
    
    // MARK: - Helper Methods
    private func makeSUT(nv: UINavigationController = UINavigationController(), factory: ViewControllerFactory = StubFactory()) -> MainCoordinator {
        MainCoordinator(rootViewController: nv, viewControllerFactory: factory)
    }
    override func setUpWithError() throws {
        let data = try Data.from(filename: "tweetFake", in: bundle, ofType: "json")!
        let data2 = try Data.from(filename: "userFake", in: bundle, ofType: "json")!
        let tweet: Tweet! = try JSONDecoder().decode(Tweet.self, from: data)
        let user: User! = try JSONDecoder().decode(User.self, from: data2)
        self.sut_tweetvm = TweetViewModel(tweet)
        self.sut_uservm = UserViewModel(user)
    }
   
}

// MARK: - Stubs
private class StubFactory: ViewControllerFactory {
   
    
    func detailViewController( tweetViewModel: TweetViewModel, userViewModel: UserViewModel, userImage: UIImage) -> UIViewController {
        return DetailViewController(tweetViewModel, userViewModel, UIImage(named: "gato")!)
    }
    
    func feedViewController() -> UIViewController {
        return FeedViewController()
    }
}
