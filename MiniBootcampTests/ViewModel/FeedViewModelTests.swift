//
//  ViewModelTests.swift
//  MiniBootcampTests
//
//  Created by Heber Raziel Alvarez Ruedas on 28/06/22.
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
    // When
    sut.fetchTweetTimeLine()
    // Then
    XCTAssertEqual(sut.state.value, .loading)
  }

  func testFetchTweet_WhenFetchingFinished_ReturnsSuccessState() throws {
    // Given
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
    // When
    sut.fetchTweetTimeLine()
    // Then
    wait(for: [expectation], timeout: 3.0)
    XCTAssertTrue(changeState)
  }

  func testFetchTweet_WhenFetchingUnfinished_ReturnsFailureState() throws {
    // Given
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
    // When
    sut.fetchTweetTimeLine()
    // Then
    wait(for: [expectation], timeout: 3.0)
    XCTAssertTrue(failureState)
  }
}

