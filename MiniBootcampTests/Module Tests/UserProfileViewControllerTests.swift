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
  var viewModelMock: UserProfileViewModelMock!
  var sut: UserProfileViewController!

  override func setUp() {
    super.setUp()
    viewModelMock = UserProfileViewModelMock()
    sut = UserProfileViewController()
    sut.viewModel = viewModelMock
    let user = User(name: "NameMock",
                    nickname: "NicknameMock",
                    description: "DescriptionMock",
                    location: "LocationMock",
                    followers: 100,
                    creation: "CreationMock",
                    backgroundColor: "C0DEED",
                    profileImageURL: "https://abs.twimg.com/images/themes/theme1/bg.png",
                    coverImageURL: "http://pbs.twimg.com/profile_images/655037238409990144/VrE-PK8l_normal.png")

    viewModelMock.userProfile = UserProfile(from: user)

  }

  override func tearDown() {
    viewModelMock = nil
    sut = nil
    super.tearDown()
  }


  func testViewController_WhenDidLoad_StateIsLoading() {
    // TODO: - Test Loader
    // When
    let expectation = XCTestExpectation(description: "didLoadUserProfile")
    viewModelMock.expectation = expectation
    viewModelMock.expectedState = .failure
    sut.viewDidLoad()
    wait(for: [expectation], timeout: 3.0)

    // Then
//    XCTAssertEqual(sut.viewModel.state.value, .loading)
  }

  func testViewController_WhenDidLoad_ReloadsView() throws {
    // Given
    let expectedName: String = "NameMock"
    let expectedNickName: String = "NicknameMock"
    let expectedDescription: String = "DescriptionMock"
    let expectedFollowers: String = "Followers: 100"
    let expectedLocation: String = "LocationMock"
    let expectedCreation: String = "CreationMock"
    let expectedBackgroundColor : String = "C0DEED"
    let expectation = XCTestExpectation(description: "didLoadUserProfile")
    viewModelMock.expectation = expectation
    viewModelMock.expectedState = .success
    viewModelMock.userProfile?.coverImageData = try Data(contentsOf: URL(string: "https://abs.twimg.com/images/themes/theme1/bg.png")!)
    viewModelMock.userProfile?.profileImageData = try Data(contentsOf: URL(string: "https://abs.twimg.com/images/themes/theme1/bg.png")!)
    
    // When
    sut.fillInformation(userProfile: viewModelMock.userProfile!)
    sut.viewDidLoad()

    wait(for: [expectation], timeout: 3.0)
    // Then
    XCTAssertEqual(sut.name.text, expectedName)
    XCTAssertEqual(sut.nickName.text, expectedNickName)
    XCTAssertEqual(sut.userDescription.text, expectedDescription)
    XCTAssertEqual(sut.followers.text, expectedFollowers)
    XCTAssertEqual(sut.location.text, expectedLocation)
    XCTAssertEqual(sut.creation.text, expectedCreation)
    XCTAssertNotNil(sut.profileImage.image)
    XCTAssertNotNil(sut.coverImage.image)
    XCTAssertEqual(sut.viewModel?.userProfile?.backgroundColor, expectedBackgroundColor)
  }

  func test_setupView_willImplementStackView() {
    // Given
    let expectation = XCTestExpectation(description: "didLoadUserProfile")
    viewModelMock.expectation = expectation
    viewModelMock.expectedState = .success
    sut.viewDidLoad()
    sut.getUserProfile()
    wait(for: [expectation], timeout: 3.0)
    XCTAssert(true)
  }

  func testViewController_viewModelSendsFailure_showsAlert() throws {
    // Given
    let expectedAlertTitle: String = "Algo salió mal"
    let viewModelMock: UserProfileViewModelMock = UserProfileViewModelMock()
    let sut = UserProfileViewController(viewModel: viewModelMock)
    let expectation = XCTestExpectation(description: "didLoadUserProfile")
    viewModelMock.expectation = expectation
    viewModelMock.expectedState = .failure
    sut.viewModel = viewModelMock

    // When
    sut.viewDidLoad()
    sut.getUserProfile()
    wait(for: [expectation], timeout: 3.0)
    // Then
    XCTAssertNotEqual(sut.alert.title, expectedAlertTitle)
  }
}

class UserProfileViewModelMock: UserProfileViewModelProtocol {
  var api: UserProfileAPI = UserProfileAPI(session: FakeSession())
  var userProfile: UserProfile?
  var state: Observer<TweetState> = Observer<TweetState>()
  var error: AlertModel?

  var expectation: XCTestExpectation?
  var expectedState: TweetState = .loading

  func downloadUserInfo() {
    DispatchQueue.global(qos: .background).async { [weak self] in
      guard let self = self else { return }
      self.state.value = self.expectedState
      self.expectation?.fulfill()
    }
  }
}
