//
//  TweetTimelineAPITests.swift
//  Mini bootcampTests
//
//  Created by Abner Castro on 22/04/22.
//

import XCTest
@testable import MiniBootcamp

class TweetTimelineAPITests: XCTestCase {
    
    var sut: TweetTimelineAPI!
    
    override func setUp() {
        super.setUp()
        sut = makeSut()
    }
    
    func test_loadTimelineSuccessfully() throws {
        let realSut = TweetTimelineAPI(session: .shared)
        var timeline: [Tweet] = []
        let expectation = expectation(description: "timeline expection")
        realSut.load(.timeline) { response in
            switch response {
            case .success(let tweets):
                timeline = tweets
                expectation.fulfill()
            case .failure(let error):
                XCTAssertThrowsError(error)
            }
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertTrue(timeline.count > 0)
    }
    
    func test_loadTimeline_withError_errorResponse() {
        let expectation = expectation(description: "timeline expection")
        var expectedError: Error?
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else { throw TweetAPIError.response }
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, nil, TweetAPIError.response)
        }
        
        sut.load(.timeline) { response in
            switch response {
            case .success(_):
                print("not used")
            case .failure(let error):
                expectedError = error
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(expectedError)
    }
    
    func test_loadTimeline_withError_parsingData() throws {
        let expectation = expectation(description: "timeline expection")
        var expectedError: TweetAPIError?
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else { throw TweetAPIError.response }
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, nil, nil)
        }
        
        sut.load(.timeline) { response in
            switch response {
            case .success(_):
                print("not used")
            case .failure(let error):
                expectedError = error as? TweetAPIError
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
        let unwrappedError = try XCTUnwrap(expectedError)
        XCTAssertEqual(unwrappedError, .parsingData)
    }
    
    func test_loadTimeline_withError_noData() throws {
        let session = URLSessionMock()
        let tweetAPI = TweetTimelineAPI(session: session)
        var expectedError: TweetAPIError?
        let expectation = expectation(description: "no data expectation")
        tweetAPI.load(.timeline) { result in
            switch result {
            case .success(_):
                print("not used in this test")
            case .failure(let error):
                expectedError = error as? TweetAPIError
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 5.0)
        let unwrappedError = try XCTUnwrap(expectedError)
        XCTAssertEqual(unwrappedError, .noData)
    }
    
    // MARK: - Helper Methods
    
    private func makeSut() -> TweetTimelineAPI {
        let config = URLSessionConfiguration.default
        config.protocolClasses = [MockURLProtocol.self]
        return TweetTimelineAPI(session: URLSession(configuration: config))
    }
    
    private class DataTaskMock: URLSessionDataTask {
        let closure: () -> ()
        
        init(closure: @escaping () -> ()) {
            self.closure = closure
        }
        
        override func resume() {
            closure()
        }
    }
    
    private class URLSessionMock: URLSession {
        typealias CompletionHandler = (Data?, URLResponse?, Error?) -> ()
        
        var data: Data?
        var error: Error?
        
        override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            
            DataTaskMock {
                completionHandler(self.data, nil, self.error)
            }
            
        }
    }
    
    private class MockURLProtocol: URLProtocol {
        
        static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?, Error?))?
        
        override class func canInit(with request: URLRequest) -> Bool {
            true
        }
        
        override class func canonicalRequest(for request: URLRequest) -> URLRequest {
            request
        }
        
        override func startLoading() {
            guard let handler = MockURLProtocol.requestHandler else {
                fatalError("Handler is unavailable")
            }
            
            do {
                let (response, data, error) = try handler(request)
                client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                if let error = error {
                    client?.urlProtocol(self, didFailWithError: error)
                } else if let data = data {
                    client?.urlProtocol(self, didLoad: data)
                } else {
                    client?.urlProtocolDidFinishLoading(self)
                }
            } catch {
                client?.urlProtocol(self, didFailWithError: error)
            }
            
        }
        
        override func stopLoading() {
            
        }
    }
    
    // MARK: - TearDown project
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
}
