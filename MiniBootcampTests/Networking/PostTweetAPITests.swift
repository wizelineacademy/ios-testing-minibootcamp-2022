//
//  PostTweetAPITests.swift
//  MiniBootcampTests
//
//  Created by Heber Raziel Alvarez Ruedas on 02/07/22.
//

import XCTest
@testable import MiniBootcamp

class PostTweetAPITests: XCTestCase {
  var sut: PostTweetAPI!
  private var session: FakeSession!

  override func setUp() {
    super.setUp()
    session = FakeSession()
    sut = PostTweetAPI(session: session)
  }

  override func tearDown() {
    session = nil
    sut = nil
    super.tearDown()
  }

  func test_networkResponse_isEstablished() {
    // Given
    let expectation = expectation(description: "Post tweet expectation")
    var response = false
    // When
    sut.send(.postTweet) { result in
      response = true
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 3.0)
    XCTAssertTrue(response)
  }

  func test_networkResponse_withError() {
    // Given
    let expectation = expectation(description: "Post tweet error")
    var expectedError: TweetAPIError?
    session.error = TweetAPIError.response
    // When
    sut.send(.postTweet) { result in
      switch result {
      case .failure(let error):
        expectedError = error as? TweetAPIError
        expectation.fulfill()
      default:
        break
      }
    }
    wait(for: [expectation], timeout: 3.0)
    XCTAssertNotNil(expectedError)

  }

  func test_networkResponse_withNoData() throws {
    // Given
    let expectation = expectation(description: "Post Tweet error: No data")
    var expectedError: TweetAPIError?
    // When
    sut.send(.postTweet) { result in
      switch result {
      case .failure(let error):
        expectedError = error as? TweetAPIError
        expectation.fulfill()
      default:
        break
      }
    }
    wait(for: [expectation], timeout: 3.0)
    let unwrappedError = try XCTUnwrap(expectedError)
    XCTAssertEqual(unwrappedError, .noData)
  }

  func test_networkResponse_withInternalServerError() throws {
    // Given
    let expectation = expectation(description: "Post Tweet error: No data")
    var expectedError: TweetAPIError?
    session.data = Data()
    session.response = HTTPURLResponse(url: URL(string: "https://wizemock.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    // When
    sut.send(.postTweet) { result in
      switch result {
      case .failure(let error):
        expectedError = error as? TweetAPIError
        expectation.fulfill()
      default:
        break
      }
    }
    wait(for: [expectation], timeout: 3.0)
    let unwrappedError = try XCTUnwrap(expectedError)
    XCTAssertEqual(unwrappedError, .internalServer)
  }

  func test_networkResponse_Successful() throws {
    // Given
    let expectation = expectation(description: "Post Tweet successful")
    var tweet: Tweet?
    session.data = try TweetMock().tweetData()
    // When
    sut.send(.postTweet) { result in
      switch result {
      case .success(let response):
        tweet = response
        expectation.fulfill()
      default:
        break
      }
    }
    wait(for: [expectation], timeout: 3.0)
    let unwrappedResponse = try XCTUnwrap(tweet)
    XCTAssertNotNil(unwrappedResponse)
  }
}
