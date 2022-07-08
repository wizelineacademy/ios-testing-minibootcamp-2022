//
//  TweetMock.swift
//  MiniBootcampTests
//
//  Created by Heber Raziel Alvarez Ruedas on 21/06/22.
//

import Foundation
@testable import MiniBootcamp

class TweetMock {
  func tweetData() throws -> Data {
    guard let path = Bundle(for: type(of: self)).path(forResource: "tweetFake", ofType: "json") else { fatalError("Couldn't find tweetFake.json file") }

    let data = try Data(contentsOf: URL(fileURLWithPath: path))
    return data
  }

  func tweetsData() throws -> Data {
    guard let path = Bundle(for: type(of: self)).path(forResource: "tweetsFake", ofType: "json") else { fatalError("Couldn't find tweetsFake.json file") }

    let data = try Data(contentsOf: URL(fileURLWithPath: path))
    return data
  }
}
