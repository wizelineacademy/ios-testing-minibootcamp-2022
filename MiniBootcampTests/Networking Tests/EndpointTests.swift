//
//  EndpointTests.swift
//  Mini bootcampTests
//
//  Created by Abner Castro on 07/04/22.
//

import XCTest
@testable import MiniBootcamp

class EndpointTests: XCTestCase {
    
    func test_baseURL() {
        XCTAssertEqual(Endpoint.baseURL, "https://wizetwitterproxy.herokuapp.com")
    }
    
    func test_timeline_endPointString() {
        XCTAssertEqual(Endpoint.timeline.string, "/api/statuses/user_timeline")
    }
    
    func test_timelineURL() {
        let sut = Endpoint.timeline
        let request = sut.request
        XCTAssertEqual(request.url?.absoluteString, "https://wizetwitterproxy.herokuapp.com/api/statuses/user_timeline")
    }
}
