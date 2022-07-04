//
//  ComposeTweetViewControllerTests.swift
//  MiniBootcampTests
//
//  Created by Heber Raziel Alvarez Ruedas on 01/07/22.
//

import Foundation
@testable import MiniBootcamp
import XCTest

final class ComposeTweetViewControllerTests: XCTestCase {
  var sut: ComposeTweetViewController!

  override func setUp() {
    super.setUp()
    sut = ComposeTweetViewController()
    sut.loadViewIfNeeded()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }

  func test_backgroundColor_isWhite() {
    XCTAssertEqual(sut.view.backgroundColor, UIColor.white)
  }

  func test_textView_isNotNil() {
    XCTAssertNotNil(sut.textView)
  }

  func test_textView_initialConfiguration() throws {
    // Given
    let expectedTextViewBackgroundColor: UIColor = .systemBackground
    // When
    sut.viewDidLoad()
    // Then
    XCTAssertEqual(sut.textView.backgroundColor, expectedTextViewBackgroundColor)
  }

  func test_tweetButton_initialConfiguration() {
    // Given
    let expectedBackgroundColor: UIColor = UIColor.orange
    let expectedCornerRadius: CGFloat = 14
    // Then
    XCTAssertEqual(sut.tweetButtonView.backgroundColor, expectedBackgroundColor)
    XCTAssertEqual(sut.tweetButtonView.layer.cornerRadius, expectedCornerRadius)
  }

  func test_tweetLabel_initialConfiguration() throws {
    // Given
    let expectedText: String = "Tweet"
    let expectedFont: UIFont = try XCTUnwrap( .normal(withSize: .name))
    let expectedTextColor: UIColor = .white
    let expectedTextAlignment: NSTextAlignment = .center
    // Then
    XCTAssertEqual(sut.tweetLabel.text, expectedText)
    XCTAssertEqual(sut.tweetLabel.font, expectedFont)
    XCTAssertEqual(sut.tweetLabel.textColor, expectedTextColor)
    XCTAssertEqual(sut.tweetLabel.textAlignment, expectedTextAlignment)
  }

  func test_stackView_initialConfiguration() throws {
    // Given
    let expectedDistribution: UIStackView.Distribution = .fill
    let expectedBackgroundColor: UIColor = .systemBackground
    let expectedArrangedSubviewsCount: Int = 1
    let expectedStackViewTag: Int = Int.zero
    // Then
    XCTAssertNotNil(sut.stackView)
    XCTAssertEqual(sut.stackView.distribution, expectedDistribution)
    XCTAssertEqual(sut.stackView.backgroundColor, expectedBackgroundColor)
    XCTAssertEqual(sut.stackView.arrangedSubviews.count, expectedArrangedSubviewsCount)
    XCTAssertEqual(sut.stackView.tag, expectedStackViewTag)
  }

  func test_characterCountLabel_initialConfiguration() throws {
    // Given
    let expectedBackgroundColor: UIColor = .orange
    // Then
    XCTAssertNotNil(sut.stackView.arrangedSubviews[0])
    XCTAssertEqual(sut.stackView.arrangedSubviews[0].backgroundColor, expectedBackgroundColor)
  }

  func test_keyboardInitialSpaceFromBottom_ReturnsEightPoints() {
    // Given
    let defaultBottomSpace: CGFloat = 8.0
    // When
    XCTAssertEqual(sut.bottomSpace, defaultBottomSpace)
    sut.viewWillAppear(true)
    sut.onKeyboardWillChangeFrame(Notification(name: UIResponder.keyboardWillChangeFrameNotification, object: self, userInfo: nil) as NSNotification)
    // Then
    XCTAssertTrue(sut.bottomSpace != defaultBottomSpace)
  }

  func test_performTweet_initialStateIsLoading() {
    // Given
    let expectedState: TweetState = .loading
    // When
    sut.performTweet()
    // Then
    XCTAssertEqual(sut.viewModel.state.value, expectedState)
  }

  func test_shouldChangeText_returnsTrueIfLessThan140Characters() {
    // Given
    (sut.stackView.arrangedSubviews[0] as? UILabel)?.text = "a"
    sut.textView.text = "This text has less than 140 characters"
    // When
    let shouldChangeText: Bool = sut.textView(sut.textView, shouldChangeTextIn: NSRange(location: 1, length: 0), replacementText: "a")
    // Then
    XCTAssertTrue(shouldChangeText)
  }

  func test_shouldChangeText_returnsFalseIfGreaterThan140Characters() {
    // Given
    (sut.stackView.arrangedSubviews[0] as? UILabel)?.text = "a"
    sut.textView.text = """
This text has 140 characters,
This text has 140 characters,
This text has 140 characters,
This text has 140 characters,
This text has 140 ch
"""
    // When
    let shouldChangeText: Bool = sut.textView(sut.textView, shouldChangeTextIn: NSRange(location: 1, length: 0), replacementText: "a")
    // Then
    XCTAssertFalse(shouldChangeText)
  }
}
