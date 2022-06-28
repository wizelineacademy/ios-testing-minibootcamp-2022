//
//  TweetTimelineAPITests.swift
//  MiniBootcampTests
//
//  Created by Heber Raziel Alvarez Ruedas on 21/06/22.
//

import Foundation
import XCTest
@testable import MiniBootcamp

class TweetTimelineAPITests: XCTestCase {
  var sut: TweetTimelineAPI!
  private var session: FakeSession!

  override func setUp() {
    super.setUp()
    session = FakeSession()
    sut = TweetTimelineAPI(session: session)
  }

  override func tearDown() {
    sut = nil
    session = nil
    super.tearDown()

  }

  func testNetworkResponse() {
    // Given
    let expectation = expectation(description: "tweet timeline expectation")
    var response = false

    // When
    sut.load(.timeline) { result in
      response = true
      expectation.fulfill()
      print(result)
    }
    wait(for: [expectation], timeout: 5.0)
    XCTAssertTrue(response)
  }

  func testResponseWithError() {
    // Given
    let expectation = expectation(description: "tweet timeline expectation")
    var expectedError: TweetAPIError?
    session.error = TweetAPIError.response

    // When
    sut.load(.timeline) { result in
      switch result {
      case .failure(let error):
        expectedError = error as? TweetAPIError
        expectation.fulfill()
      default:
        break
      }
      print(result)
    }
    wait(for: [expectation], timeout: 5.0)
    XCTAssertNotNil(expectedError)
  }

  func testResponseWithNoData() throws {
    // Given
    let expectation = expectation(description: "tweet timeline expectation")
    var expectedError: TweetAPIError?

    // When
    sut.load(.timeline) { result in
      switch result {
      case .failure(let error):
        expectedError = error as? TweetAPIError
        expectation.fulfill()
      default:
        break
      }
      print(result)
    }
    wait(for: [expectation], timeout: 5.0)
    let unwrappedError = try XCTUnwrap(expectedError)
    XCTAssertEqual(unwrappedError, .noData)
  }

  func testResponseWithParsingError() throws {
    // Given
    let expectation = expectation(description: "tweet timeline expectation")
    var expectedError: TweetAPIError?
    session.data = Data()

    // When
    sut.load(.timeline) { result in
      switch result {
      case .failure(let error):
        expectedError = error as? TweetAPIError

        expectation.fulfill()
      default:
        break
      }
      print(result)
    }
    wait(for: [expectation], timeout: 5.0)
    let unwrappedError = try XCTUnwrap(expectedError)
    XCTAssertEqual(unwrappedError, .parsingData)
  }

  func testResponseWithParsingSuccess() throws {
    // Given
    let expectation = expectation(description: "tweet timeline expectation")
    var timeline = [Tweet]()
    session.data = try TweetMock().tweetsData()

    // When
    sut.load(.timeline) { result in
      switch result {
      case .success(let tweets):
        timeline = tweets
        expectation.fulfill()
      default:
        break
      }
      print(result)
    }
    wait(for: [expectation], timeout: 5.0)
    XCTAssertTrue(timeline.count != 0)
  }
}

