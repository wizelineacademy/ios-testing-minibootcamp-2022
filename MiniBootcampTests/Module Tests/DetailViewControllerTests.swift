import XCTest
@testable import MiniBootcamp

class DetailViewControllerTests: XCTestCase {
    var sut_tweetvm: TweetViewModel?
    var sut_uservm: UserViewModel?
    lazy var bundle = Bundle(for: self.classForCoder)
    var sut: DetailViewController!
    func test_vc_backgroundIsSystemBackground() {
        
//
        XCTAssertNotNil(sut.view)
        XCTAssertEqual(sut.view?.backgroundColor, .systemBackground)
    }
    
    func testCellIsNotNil() {
        // Given
        // system under test
        let sut = TweetTableViewCell()
        
        // When
        
        // Then
        XCTAssertNotNil(sut)
        
    }
    
    func testBackgroundIsSystem() {
        let systemBackground = UIColor.systemBackground
        XCTAssertEqual(sut.view.backgroundColor, systemBackground)
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
        let font = UIFont.normal(withSize: .username)
        let textColor = UIColor.systemGray
        
        //Then
        XCTAssertEqual(sut.usernameLabel.font, font)
        XCTAssertEqual(sut.usernameLabel.numberOfLines, 1)
        XCTAssertEqual(sut.usernameLabel.textColor, textColor)
    }
    func testDateLabel_initialConfiguration() {
        // Given
        let font = UIFont.normal(withSize: .date)
        let textColor = UIColor.systemGray
        
        //Then
        XCTAssertEqual(sut.dateLabel.font, font)
        XCTAssertEqual(sut.dateLabel.numberOfLines, 0)
        XCTAssertEqual(sut.dateLabel.textColor, textColor)
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
    func testLikeLabel_initialConfiguration() {
        // Given
        let font = UIFont.normal(withSize: .date)
        let textColor = UIColor.systemGray
        
        //Then
        XCTAssertEqual(sut.likeLabel.font, font)
        XCTAssertEqual(sut.likeLabel.numberOfLines, 0)
        XCTAssertEqual(sut.likeLabel.textColor, textColor)
    }
    func testRetweetLabel_initialConfiguration() {
        // Given
        let font = UIFont.normal(withSize: .date)
        let textColor = UIColor.systemGray
        
        //Then
        XCTAssertEqual(sut.retweetLabel.font, font)
        XCTAssertEqual(sut.retweetLabel.numberOfLines, 0)
        XCTAssertEqual(sut.retweetLabel.textColor, textColor)
    }
    
    func testAllSubviewsAreAddedAsSubviews() {
        XCTAssertEqual(sut.view.subviews.count, 2)
    }

    override func setUpWithError() throws {
        let data = try Data.from(filename: "tweetFake", in: bundle, ofType: "json")!
        let data2 = try Data.from(filename: "userFake", in: bundle, ofType: "json")!
        let tweet: Tweet! = try JSONDecoder().decode(Tweet.self, from: data)
        let user: User! = try JSONDecoder().decode(User.self, from: data2)
        self.sut_tweetvm = TweetViewModel(tweet)
        self.sut_uservm = UserViewModel(user)
        sut = DetailViewController(sut_tweetvm!, sut_uservm!, UIImage(named: "gato")!)
    }
}
