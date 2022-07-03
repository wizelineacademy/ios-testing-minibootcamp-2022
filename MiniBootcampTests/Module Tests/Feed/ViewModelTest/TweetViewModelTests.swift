//
//  TweetViewModelTests.swift
//  MiniBootcampTests
//
//  Created by Javier Cueto on 03/07/22.
//

import XCTest
@testable import MiniBootcamp

class TweetViewModelTests: XCTestCase {
    
    func test_tweeViewModel_correctParsing() throws {
        
        guard let path = Bundle(for: type(of: self)).path(forResource: "tweetFake", ofType: "json") else { fatalError("Couldn't find tweetFake.json file") }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        print(try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed))
        let tweet = try JSONDecoder().decode(Tweet.self, from: data)
        let sut = TweetViewModel(tweet: tweet)
        
        XCTAssertEqual(sut.content, "This is an example")
        XCTAssertEqual(sut.name, "Wizeboot")
        XCTAssertEqual(sut.userName, "@wizeboot")
        
    }
}
