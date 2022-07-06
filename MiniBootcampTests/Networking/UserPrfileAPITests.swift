//
//  UserPrfileAPITests.swift
//  MiniBootcampTests
//
//  Created by Heber Raziel Alvarez Ruedas on 05/07/22.
//

import Foundation
import XCTest
@testable import MiniBootcamp

class UserProfileAPITests: XCTestCase {
  var sut: UserProfileAPI!
  private var session: FakeSession!

  override func setUp() {
    super.setUp()
    session = FakeSession()
    sut = UserProfileAPI(session: session)
  }

  override func tearDown() {
    session = nil
    sut = nil
    super.tearDown()
  }

  func testNetworkResponse() {
    // Given
    let expectation = expectation(description: "User Profile expectation")
    var response = false

    // When
    sut.load(.userProfile) { result in
      response = true
      expectation.fulfill()
    }
    wait(for: [expectation], timeout: 3.0)
    XCTAssertTrue(response)
  }

  func testResponseWithError() {
    // Given
    let expectation = expectation(description: "User Profile error expectation")
    var expectedError: TweetAPIError?
    session.error = TweetAPIError.response

    // When
    sut.load(.userProfile) { result in
      switch result {
      case .failure(let error):
        expectedError = error as? TweetAPIError
        expectation.fulfill()
      default:
        break
      }
      print(result)
    }
    wait(for: [expectation], timeout: 3.0)
    XCTAssertNotNil(expectedError)
  }

  func testResponseWithNoData() throws {
    // Given
    let expectation = expectation(description: "User Profile with no data expectation")
    var expectedError: TweetAPIError?

    // When
    sut.load(.userProfile) { result in
      switch result {
      case .failure(let error):
        expectedError = error as? TweetAPIError
        expectation.fulfill()
      default:
        break
      }
      print(result)
    }
    wait(for: [expectation], timeout: 3.0)
    let unwrappedError = try XCTUnwrap(expectedError)
    XCTAssertEqual(unwrappedError, .noData)
  }

  func testResponseWithParsingError() throws {
    // Given
    let expectation = expectation(description: "tweet timeline expectation")
    var expectedError: TweetAPIError?
    session.data = Data()

    // When
    sut.load(.userProfile) { result in
      switch result {
      case .failure(let error):
        expectedError = error as? TweetAPIError

        expectation.fulfill()
      default:
        break
      }
      print(result)
    }
    wait(for: [expectation], timeout: 3.0)
    let unwrappedError = try XCTUnwrap(expectedError)
    XCTAssertEqual(unwrappedError, .parsingData)
  }

  func testResponseWithParsingSuccess() throws {
    // Given
    let expectation = expectation(description: "tweet timeline expectation")
    var userProfile: User?
    session.data = try UserProfileMock().userData()

    // When
    sut.load(.userProfile) { result in
      switch result {
      case .success(let tweets):
        userProfile = tweets
        expectation.fulfill()
      default:
        break
      }
      print(result)
    }
    wait(for: [expectation], timeout: 3.0)
    XCTAssertNotNil(userProfile)
  }
}
