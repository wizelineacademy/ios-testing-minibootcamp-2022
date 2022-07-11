//
//  iOSViewControllerFactoryTests.swift
//  Mini bootcampTests
//
//  Created by Abner Castro on 07/04/22.
//

import XCTest
@testable import MiniBootcamp

class iOSViewControllerFactoryTests: XCTestCase {
    var sut_tweetvm: TweetViewModel?
    var sut_uservm: UserViewModel?
    lazy var bundle = Bundle(for: self.classForCoder)
    
    func test_feedViewController_isFeedViewControllerType() {
        
        let sut = iOSViewControllerFactory()
        let feedVC = sut.feedViewController() as? FeedViewController
        XCTAssertNotNil(feedVC)
        
    }
    
    func test_detailViewController_isDetailViewControllerType() {
        
        let sut = iOSViewControllerFactory()
        let feedVC = sut.detailViewController( tweetViewModel: self.sut_tweetvm!, userViewModel: self.sut_uservm!, userImage: UIImage(named:"gato")!)
        XCTAssertNotNil(feedVC)
        
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
