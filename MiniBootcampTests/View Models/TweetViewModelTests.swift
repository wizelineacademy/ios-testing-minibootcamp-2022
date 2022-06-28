//
//  TweetViewModelTests.swift
//  MiniBootcampTests
//
//  Created by Juan David Torres on 16/06/22.
//

import XCTest
@testable import MiniBootcamp
extension Data {

    static func from(filename: String, in bundle: Bundle, ofType: String) throws -> Data? {
        guard let filepath = bundle.path(forResource: filename, ofType: ofType) else { return nil }
        let json: String = try String(contentsOfFile: filepath)
        return Data(json.utf8)
    }
    
}
class TweetViewModelTests: XCTestCase {
    var sut: TweetViewModel!
    lazy var bundle = Bundle(for: self.classForCoder)
    
    func testCreateViewModelNotNilSut() {
        XCTAssertNotNil(sut)
    }
    
    func testCreateViewModelProperties() {
        XCTAssertNotNil(sut.creation)
        XCTAssertNotNil(sut.user)
        XCTAssertNotNil(sut.retweets)
        XCTAssertNotNil(sut.favs)
        XCTAssertNotNil(sut.text)
        XCTAssertNotNil(sut.id)
    }


    override func setUpWithError() throws {
        let data = try Data.from(filename: "tweetFake", in: bundle, ofType: "json")!
        let tweet: Tweet! = try JSONDecoder().decode(Tweet.self, from: data)
        self.sut = TweetViewModel(tweet)
        
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
