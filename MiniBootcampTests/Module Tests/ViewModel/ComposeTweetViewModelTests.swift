//
//  ComposeTweetViewModelTests.swift
//  MiniBootcampTests
//
//  Created by Heber Raziel Alvarez Ruedas on 03/07/22.
//

import Foundation
@testable import MiniBootcamp
import XCTest

final class ComposeTweetViewModelTests: XCTestCase {
  var fakeSession: FakeSession!
  var api: PostTweetAPI!
  var sut: ComposeTweetViewModel!

  override func setUp() {
    super.setUp()
    fakeSession = FakeSession()
    api = PostTweetAPI(session: fakeSession)
    sut = ComposeTweetViewModel(api: api)
  }

  override func tearDown() {
    fakeSession = nil
    api = nil
    sut = nil
    super.tearDown()
  }

  func testPostTweet_whenPosting_returnsLoadingState() {
    // When
    sut.postTweet()
    // Then
    XCTAssertEqual(sut.state.value, .loading)
  }
}
