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
        
        // When
        
        // Then
        XCTAssertNotNil(sut)
        
    }
    
    func testBackgroundIsSystem() {
        let systemBackground = UIColor.systemBackground
        XCTAssertEqual(sut.backgroundColor, systemBackground)
    }
    
    func testuserImageView_initialConfiguration() {
        let defaultThumb = UIImage(.gato)
        XCTAssertEqual(sut.userImageView.layer.cornerRadius, 25)
        XCTAssertTrue(sut.userImageView.clipsToBounds)
        XCTAssertEqual(sut.userImageView.image, defaultThumb)
    }
    
    func testNameLabel_initialConfiguration() {
        // Given
        let font = UIFont.bold(withSize: .name)
        let textColor = UIColor.label
        
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
        XCTAssertEqual(sut.usernameLabel.font, font)
        XCTAssertEqual(sut.usernameLabel.numberOfLines, 1)
        XCTAssertEqual(sut.usernameLabel.textColor, textColor)
    }
    
    func testContentLabel_initialConfiguration() {
        // Given
        let font = UIFont.normal(withSize: .content)
        let textColor = UIColor.label
        
        //Then
        XCTAssertEqual(sut.contentLabel.font, font)
        XCTAssertEqual(sut.contentLabel.numberOfLines, 0)
        XCTAssertEqual(sut.contentLabel.textColor, textColor)
    }
    
  func testAllSubviewsAreAddedAsSubviews() {
    XCTAssertEqual(sut.subviews.count, 5)
  }

  func testCommentButton_initialConfiguration() {
    // Given
    let buttonImage = UIImage(.comment)
    let buttonColor = UIColor.redMain

    // When

    // Then
    XCTAssertEqual(sut.commentButton.image(for: .normal), buttonImage)
    XCTAssertEqual(sut.commentButton.tintColor, buttonColor)
  }

  func testRetweetButton_initialConfiguration() {
    // Given
    let buttonImage = UIImage(.ret)
    let buttonColor = UIColor.redMain

    // When

    // Then
    XCTAssertEqual(sut.retweetButton.image(for: .normal), buttonImage)
    XCTAssertEqual(sut.retweetButton.tintColor, buttonColor)
  }

  func testFavouriteButton_initialConfiguration() {
    // Given
    let buttonImage = UIImage(.fav)
    let buttonColor = UIColor.redMain

    // When

    // Then
    XCTAssertEqual(sut.favoriteButton.image(for: .normal), buttonImage)
    XCTAssertEqual(sut.favoriteButton.tintColor, buttonColor)
  }

  func testShareButton_initialConfiguration() {
    // Given
    let buttonImage = UIImage(.share)
    let buttonColor = UIColor.redMain

    // When

    // Then
    XCTAssertEqual(sut.shareButton.image(for: .normal), buttonImage)
    XCTAssertEqual(sut.shareButton.tintColor, buttonColor)
  }

  func testStackViewHasAddedSubviews() {
    let stackView = sut.subviews.filter { $0.tag == 4 }
    print("-->", stackView.first is UIStackView)
  }
    
  override func tearDown() {
        super.tearDown()
        sut = nil
  } 
}
