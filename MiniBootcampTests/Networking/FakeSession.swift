//
//  FakeSession.swift
//  MiniBootcampTests
//
//  Created by Heber Raziel Alvarez Ruedas on 28/06/22.
//

import Foundation

class FakeSession: URLSession {
  var data: Data?
  var response: URLResponse?
  var error: Error?

  override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
    MockDataTask {
      completionHandler(self.data, self.response, self.error)
    }
  }
}

class MockDataTask: URLSessionDataTask {

  private let closure: () -> ()

  init(closure: @escaping () -> ()) {
    self.closure = closure
  }

  override func resume() {
    DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 1.0) {
      self.closure()
    }
  }
}
