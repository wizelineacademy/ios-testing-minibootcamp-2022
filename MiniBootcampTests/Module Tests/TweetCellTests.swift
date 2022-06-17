//
//  TweetCellTests.swift
//  MiniBootcampTests
//
//  Created by Abner Castro on 14/06/22.
//

import XCTest
@testable import MiniBootcamp

class TweetCellTests: XCTestCase {

  var sut: TweetCell!

  override func setUp() {
    super.setUp()
    sut = TweetCell()
  }

  func testCellIsNotNil() {
    // Given
    // system under test
    let sut = TweetCell()

    // Then
    XCTAssertNotNil(sut)

  }

  func testBackgroundIsSystem() {
    let systemBackground = UIColor.systemBackground
    XCTAssertEqual(sut.backgroundColor, systemBackground)
  }

  func testuserImageView_initialConfiguration() {
    let defaultThumb = UIImage(.gato).withRenderingMode(.alwaysTemplate)
    let defaultThumbColor = UIColor.redMain
    XCTAssertEqual(sut.userImageView.layer.cornerRadius, 25)
    XCTAssertTrue(sut.userImageView.clipsToBounds)
    XCTAssertEqual(sut.userImageView.image, defaultThumb)
    XCTAssertEqual(sut.userImageView.tintColor, defaultThumbColor)
  }

  func testNameLabel_initialConfiguration() {
    // Given
    let font = UIFont.bold(withSize: .name)
    let textColor = UIColor.black

    //Then
    XCTAssertEqual(sut.nameLabel.font, font)
    XCTAssertEqual(sut.nameLabel.numberOfLines, 1)
    XCTAssertTrue(sut.nameLabel.adjustsFontSizeToFitWidth)
    XCTAssertEqual(sut.nameLabel.textColor, textColor)
  }

  func testusernameLabel_initialConfiguration() {
    // Given
    let font = UIFont.bold(withSize: .username)
    let textColor = UIColor.systemGray

    //Then
    XCTAssertEqual(sut.userNameLabel.font, font)
    XCTAssertEqual(sut.userNameLabel.numberOfLines, 1)
    XCTAssertEqual(sut.userNameLabel.textColor, textColor)
  }

  func testContentLabel_initialConfiguration() {
    // Given
    let font = UIFont.normal(withSize: .content)
    let textColor = UIColor.black

    //Then
    XCTAssertEqual(sut.contentLabel.font, font)
    XCTAssertEqual(sut.contentLabel.numberOfLines, 0)
    XCTAssertEqual(sut.contentLabel.textColor, textColor)
  }

  func testAllSubviewsAreAddedAsSubviews() {
    XCTAssertEqual(sut.subviews.count, 6)
  }

  func testCommentButton_initialConfiguration() {
    // Given
    let buttonImage = UIImage(.comment).withRenderingMode(.alwaysTemplate)
    let buttonColor = UIColor.redMain

    // Then
    XCTAssertEqual(sut.commentButton.image(for: .normal), buttonImage)
    XCTAssertEqual(sut.commentButton.tintColor, buttonColor)
  }

  func testRetweetButton_initialConfiguration() {
    // Given
    let buttonImage = UIImage(.ret).withRenderingMode(.alwaysTemplate)
    let buttonColor = UIColor.redMain

    // Then
    XCTAssertEqual(sut.retweetButton.image(for: .normal), buttonImage)
    XCTAssertEqual(sut.retweetButton.tintColor, buttonColor)
  }

  func testFavouriteButton_initialConfiguration() {
    // Given
    let buttonImage = UIImage(.fav).withRenderingMode(.alwaysTemplate)
    let buttonColor = UIColor.redMain

    // Then
    XCTAssertEqual(sut.favoriteButton.image(for: .normal), buttonImage)
    XCTAssertEqual(sut.favoriteButton.tintColor, buttonColor)
  }

  func testShareButton_initialConfiguration() {
    // Given
    let buttonImage = UIImage(.share).withRenderingMode(.alwaysTemplate)
    let buttonColor = UIColor.redMain

    // Then
    XCTAssertEqual(sut.shareButton.image(for: .normal), buttonImage)
    XCTAssertEqual(sut.shareButton.tintColor, buttonColor)
  }

  func testStackViewHasAddedSubviews() throws {
    // Given
    let stackView = try XCTUnwrap(sut.subviews.first { $0.tag == 4 })
    
    // Then
    XCTAssertTrue(stackView.subviews.count == 4)
  }

  override func tearDown() {
    super.tearDown()
    sut = nil
  }
}
