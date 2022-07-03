//
//  FeedViewModelTests.swift
//  MiniBootcampTests
//
//  Created by Javier Cueto on 03/07/22.
//

import XCTest
@testable import MiniBootcamp

class FeedViewModelTests: XCTestCase {
    var sut: FeedViewModel!
    var api: TweetTimelineAPI!
    var fakeSession: FakeSession!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        fakeSession = FakeSession()
        api = TweetTimelineAPI(session: fakeSession)
        sut = FeedViewModel(api: api)
    }
    
    override func tearDownWithError() throws {
        fakeSession = nil
        api = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    func testFetchTweet_WhenFetching_ReturnsLoadingState() {
        sut.fetchTweetTimeLine()
        XCTAssertEqual(sut.state.value, .loading)
    }
    
    func testFetchTweet_WhenFetchingFinished_ReturnsSuccessState() throws {
        fakeSession.data = try TweetMock().tweetsData()
        var changeState: Bool = false
        let expectation = expectation(description: "Fetched tweet timeline")
        sut.state.bind { state in
            switch state {
            case .success:
                changeState = true
                expectation.fulfill()
            default:
                break
            }
        }
        sut.fetchTweetTimeLine()
        wait(for: [expectation], timeout: 4.0)
        XCTAssertTrue(changeState)
    }
    
    func testFetchTweet_WhenFetchingUninished_ReturnsFailureState() throws {
        fakeSession.data = try TweetMock().tweetData()
        var failureState: Bool = false
        let expectation = expectation(description: "Fetched tweet timeline")
        sut.state.bind { state in
            switch state {
            case .failure:
                failureState = true
                expectation.fulfill()
            default:
                break
            }
        }
        sut.fetchTweetTimeLine()
        wait(for: [expectation], timeout: 5.0)
        XCTAssertTrue(failureState)
    }
    
    func testFetchedTweetTimeline_WhenSuccessfulState() throws {
        fakeSession.data = try TweetMock().tweetsData()
        let expectation = expectation(description: "Fetched tweet timeline")
        sut.state.bind { state in
            switch state {
            case .success:
                expectation.fulfill()
            default:
                break
            }
        }
        sut.fetchTweetTimeLine()
        wait(for: [expectation], timeout: 4.0)
        XCTAssertTrue(sut.timeline.count > 0)
    }
}

