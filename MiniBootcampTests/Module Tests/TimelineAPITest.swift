//
//  TimelineAPITest.swift
//  MiniBootcampTests
//
//  Created by Juan David Torres on 10/06/22.
//

import XCTest
@testable import MiniBootcamp

class TimelineAPITest: XCTestCase {
    
    func testTimelineAPIHasTweetsTest() {
        // Given
        let sut = TweetTimelineAPI()
        var error: Error?
        var tweets: [Tweet] = []
        let expectation = self.expectation(description: "Waiting for async method")
        
        // When
        sut.load(.timeline, completion: { result in
            switch(result) {
            case .success(let _tweets):
                tweets = _tweets
            case .failure(let _error):
                error = _error
                XCTFail("Failed \(String(describing: error?.localizedDescription))")
            }
            expectation.fulfill()
        })
        self.waitForExpectations(timeout: 20)
        
        // Then
        XCTAssertNil(error)
        XCTAssertNotNil(tweets)
        XCTAssertNotEqual(tweets.count, 0)
        let first: Tweet? = tweets.first
        XCTAssertNotNil(first)
    }
//    func testTimelineAPINoTweetsTest() {
//        // Given
//        let sut = TweetTimelineAPI()
//        var error: Error?
//        let expectation = self.expectation(description: "Waiting for async method")
//
//        // When
//        sut.load(.timeline, completion: { result in
//            guard case .failure(let _error) = result else {
//                XCTFail()
//                return
//            }
//            error = _error
//            expectation.fulfill()
//        })
//        self.waitForExpectations(timeout: 20)
//
//        // Then
//        XCTAssertNotNil(error)
//        XCTAssertNotNil(error is TweetAPIError)
//    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
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
