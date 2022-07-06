//
//  UserProfileViewControllerTests.swift
//  MiniBootcampTests
//
//  Created by Heber Raziel Alvarez Ruedas on 04/07/22.
//

import Foundation
import XCTest
@testable import MiniBootcamp

class UserProfileViewControllerTests: XCTestCase {
  var sut: UserProfileViewController!

  override func setUp() {
    super.setUp()
    sut = UserProfileViewController()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func test_userProfileBackground_returnsWhite() {
    // Given
    let expectedBackgroundColor: UIColor = .white
    // Then
    XCTAssertEqual(sut.view.backgroundColor, expectedBackgroundColor)
  }

  func testViewController_WhenDidLoad_StateIsLoading() {
    // TODO: - Test Loader
    // When
    sut.viewDidLoad()

    // Then
    XCTAssertEqual(sut.viewModel.state.value, .loading)
  }

  func testViewController_WhenDidLoad_ReloadsView() throws {
    // Given
    let expectedName: String = "NicknameMock"
    let viewModelMock: UserProfileViewModelMock = UserProfileViewModelMock()
    let sut = UserProfileViewController(viewModel: viewModelMock)
    let expectation = XCTestExpectation(description: "didLoadUserProfile")
    viewModelMock.expectation = expectation
    viewModelMock.expectedState = .success
    sut.viewModel = viewModelMock

    // When
    sut.viewDidLoad()

    wait(for: [expectation], timeout: 10.0)
    // Then
    XCTAssertEqual(sut.someLabel.text, expectedName)
  }

  func testViewController_viewModelSendsFailure_showsAlert() throws {
    // Given
    let viewModelMock: UserProfileViewModelMock = UserProfileViewModelMock()
    let sut = UserProfileViewController(viewModel: viewModelMock)
    let expectation = XCTestExpectation(description: "didLoadUserProfile")
    viewModelMock.expectation = expectation
    viewModelMock.expectedState = .failure
    sut.viewModel = viewModelMock

    // When
    sut.viewDidLoad()

    wait(for: [expectation], timeout: 1.0)
    // Then
    // check alert
  }
}

class UserProfileViewModelMock: UserProfileViewModelProtocol {
  var api: UserProfileAPI = UserProfileAPI(session: FakeSession())
  var userProfile: User? = User(name: "NameMock",
                                nickname: "NicknameMock",
                                description: "DescriptionMock",
                                location: "LocationMock",
                                followers: 100,
                                creation: "CreationMock",
                                backgroundColor: "BackgroundMock",
                                profileImageURL: nil,
                                coverImageURL: nil)
  var state: Observer<TweetState> = Observer<TweetState>()

  var expectation: XCTestExpectation?
  var expectedState: TweetState = .loading

  func downloadUserInfo() {
    // fue a traer la info
    DispatchQueue.global(qos: .background).async {
      self.state.value = self.expectedState
      self.expectation?.fulfill()
    }
  }
}
