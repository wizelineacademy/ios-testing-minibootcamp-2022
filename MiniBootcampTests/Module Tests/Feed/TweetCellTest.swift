//
//  TweetCellTest.swift
//  MiniBootcampTests
//
//  Created by Javier Cueto on 14/06/22.
//

import XCTest
@testable import MiniBootcamp

class TweetCellTest: XCTestCase {
	
	var sut: TweetCell!
	
	override func setUp()  {
		super.setUp()
		sut = TweetCell()
	}
	
    
    func testInitWithCoder() {
        sut = TweetCell(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
	func testCellIsNotNill() {
		XCTAssertNotNil(sut)
	}
	
	func testBackgroundIsSystem() {
        let systemBackGround = UIColor.systemBackground
		XCTAssertEqual(sut.backgroundColor, systemBackGround)
	}
	
	func testUserImageView_initialConfiguration() {
		let defaultThumb = UIImage(.gato)
		
		XCTAssertEqual(sut.userImageView.layer.cornerRadius, 25)
		XCTAssertTrue(sut.userImageView.clipsToBounds)
		XCTAssertEqual(sut.userImageView.image, defaultThumb)
	}
    
    func mainContainerStackView_InitialConfiguration() {
        XCTAssertEqual(sut.mainContainerStackView.axis, .vertical)
        XCTAssertEqual(sut.mainContainerStackView.subviews.count, 2)
        XCTAssertEqual(sut.mainContainerStackView.spacing, 10)
    }
	
	func testNameLabel_InitialConfiguration() {
		let font = UIFont.bold(withSize: .name)
		let textColor = UIColor.label
		
		XCTAssertEqual(sut.nameLabel.font, font)
		XCTAssertEqual(sut.nameLabel.numberOfLines, 1)
		XCTAssertTrue(sut.nameLabel.adjustsFontSizeToFitWidth)
		XCTAssertEqual(sut.nameLabel.textColor, textColor)
	}
	
	func testUserLabel_InitialConfiguration() {
		let font = UIFont.bold(withSize: .username)
		let textColor = UIColor.systemGray
		XCTAssertEqual(sut.userLabel.font, font)
		XCTAssertEqual(sut.userLabel.numberOfLines, 1)
		XCTAssertEqual(sut.userLabel.textColor, textColor)
	}
	
	func testContentLabel_InitialConfiguration() {
		let font = UIFont.normal(withSize: .content)
		let textColor = UIColor.label
		
		XCTAssertEqual(sut.contentLabel.font, font)
		XCTAssertEqual(sut.contentLabel.numberOfLines, 0)
		XCTAssertEqual(sut.contentLabel.textColor, textColor)
	}
	
	func testLabelsContainerStackView_InitialConfiguration() {
		XCTAssertEqual(sut.labelContainerStackView.axis, .vertical)
		XCTAssertEqual(sut.labelContainerStackView.subviews.count, 3)
	}
	
	func testOptionsContainerStackView_InitialConfiguration() {
		XCTAssertEqual(sut.optionsContainerStackView.axis, .horizontal)
		XCTAssertEqual(sut.optionsContainerStackView.subviews.count, 4)
	}
	
	func testCommentButton_InitialConfiguration() {
		let icon = UIImage(.comment).withRenderingMode(.alwaysTemplate)
		XCTAssertEqual(sut.commentButton.imageView?.image, icon)
		XCTAssertEqual(sut.commentButton.tintColor, .redMain)
	}
	
	func testRetweetButton_InitialConfiguration() {
		let icon = UIImage(.ret).withRenderingMode(.alwaysTemplate)
		XCTAssertEqual(sut.retweetButton.imageView?.image, icon)
		XCTAssertEqual(sut.retweetButton.tintColor, .redMain)
	}
	
	func testFavoriteButton_InitialConfiguration() {
		let icon = UIImage(.fav).withRenderingMode(.alwaysTemplate)
		XCTAssertEqual(sut.favoriteButton.imageView?.image, icon)
		XCTAssertEqual(sut.favoriteButton.tintColor, .redMain)
	}
	
	func testShareButton_InitialConfiguration() {
		let icon = UIImage(.share).withRenderingMode(.alwaysTemplate)
		XCTAssertEqual(sut.shareButton.imageView?.image, icon)
		XCTAssertEqual(sut.shareButton.tintColor, .redMain)
	}
	
	func testAllSubviewsAreAddedAsSubviews() {
		XCTAssertEqual(sut.subviews.count,2)
	}
	
	override func tearDown()  {
		super.tearDown()
		sut = nil
	}

}
