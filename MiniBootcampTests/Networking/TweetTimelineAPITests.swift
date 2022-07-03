//
//  TweetTimelineAPITests.swift
//  MiniBootcampTests
//
//  Created by Abner Castro on 21/06/22.
//

import XCTest
@testable import MiniBootcamp

class TweetTimelineAPITests: XCTestCase {
    
    var sut: TweetTimelineAPI!
    private var session: FakeSession!
    
    override func setUp() {
        super.setUp()
        session = FakeSession()
        sut = TweetTimelineAPI(session: session)
        
    }
    
    func testNetworkResponse() {
        // given
        let expectation = expectation(description: "tweettimeline expectation")
        var response = false
        
        // when
        sut.load(.timeline) { result in
            response = true
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
        XCTAssertTrue(response)
    }
    
    func testResponseWithError() {
        // given
        let expectation = expectation(description: "tweettimeline expectation")
        var expectedError: TweetAPIError?
        session.error = TweetAPIError.response
        
        // when
        sut.load(.timeline) { result in
            switch result {
            case .failure(let error):
                expectedError = error as? TweetAPIError
                expectation.fulfill()
            default:
                break
            }
        }
        
        // then
        wait(for: [expectation], timeout: 3.0)
        XCTAssertNotNil(expectedError)
    }
    
    func testResponseWithNoData() throws {
        // given
        let expectation = expectation(description: "tweettimeline expectation")
        var expectedError: TweetAPIError?
        
        // when
        sut.load(.timeline) { result in
            switch result {
            case .failure(let error):
                expectedError = error as? TweetAPIError
                expectation.fulfill()
            default:
                break
            }
        }
        
        // then
        wait(for: [expectation], timeout: 3.0)
        let unwrappedError = try XCTUnwrap(expectedError)
        XCTAssertEqual(unwrappedError, .noData)
    }
    
    func testResponseWithParsingError() throws {
        // given
        let expectation = expectation(description: "tweettimeline expectation")
        var expectedError: TweetAPIError?
        session.data = Data()
        
        
        // when
        sut.load(.timeline) { result in
            switch result {
            case .failure(let error):
                expectedError = error as? TweetAPIError
                expectation.fulfill()
            default:
                break
            }
        }
        
        // then
        wait(for: [expectation], timeout: 3.0)
        let unwrappedError = try XCTUnwrap(expectedError)
        XCTAssertEqual(unwrappedError, .parsingData)
    }

    private class FakeSession: URLSession {
        
        var data: Data?
        var error: Error?
        
        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            
            MockDataTask {
                completionHandler(self.data, nil, self.error)
            }
            
        }
        
    }
    
    private class MockDataTask: URLSessionDataTask {
        
        private let closure: () -> ()
        
        init(closure: @escaping () -> ()) {
            self.closure = closure
        }
        
        override func resume() {
            closure()
        }
    }
    
    
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        session = nil
    }

}
