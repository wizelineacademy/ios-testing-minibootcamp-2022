//
//  UserProfileViewModelTests.swift
//  MiniBootcampTests
//
//  Created by Heber Raziel Alvarez Ruedas on 04/07/22.
//

import XCTest
@testable import MiniBootcamp

class UserProfileViewModelTests: XCTestCase {
  var fakeSession: FakeSession!
  var api: UserProfileAPI!
  var sut: UserProfileViewModel!

  override func setUp() {
    super.setUp()
    fakeSession = FakeSession()
    api = UserProfileAPI(session: fakeSession)
    sut = UserProfileViewModel(api: api)
  }

  override func tearDown() {
    fakeSession = nil
    api = nil
    sut = nil
    super.tearDown()
  }

  func testFetchTweet_WhenFetching_ReturnsLoadingState() {
    // When
    sut.downloadUserInfo()
    // Then
    XCTAssertEqual(sut.state.value, .loading)
  }

  func testFetchProfile_WhenFetchingFinished_ReturnsSuccessState() throws {
    // Given
    fakeSession.data = try UserProfileMock().userData()
    var changeState: Bool = false
    let expectation = expectation(description: "Fetched user profile")
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
    sut.downloadUserInfo()
    // Then
    wait(for: [expectation], timeout: 3.0)
    XCTAssertTrue(changeState)
  }

  func testFetchProfile_WhenFetchingUnfinished_ReturnsFailureState() throws {
    // Given
    fakeSession.data = Data()
    var failureState: Bool = false
    let expectation = expectation(description: "Unfinished fetched user profile")
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
    sut.downloadUserInfo()
    wait(for: [expectation], timeout: 3.0)
    XCTAssertTrue(failureState)
  }
}



