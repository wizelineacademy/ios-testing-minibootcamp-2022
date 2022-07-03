//
//  FakeSessionTests.swift
//  MiniBootcampTests
//
//  Created by Javier Cueto on 03/07/22.
//

import XCTest

class FakeSession: URLSession {
    var data: Data?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        MockDataTask {
            completionHandler(self.data, nil, self.error)
        }
    }
}

class MockDataTask: URLSessionDataTask {
    
    private let closure: () -> ()
    
    init(closure: @escaping () -> ()) {
        self.closure = closure
    }
    
    override func resume() {
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3.0) {
            self.closure()
        }
    }
}
