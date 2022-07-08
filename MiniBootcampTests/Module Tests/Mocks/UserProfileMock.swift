//
//  UserProfileMock.swift
//  MiniBootcampTests
//
//  Created by Heber Raziel Alvarez Ruedas on 04/07/22.
//

import Foundation

import Foundation
@testable import MiniBootcamp

class UserProfileMock {
  func userData() throws -> Data {
    guard let path = Bundle(for: type(of: self)).path(forResource: "userFake", ofType: "json") else { fatalError("Couldn't find tweetFake.json file") }

    let data = try Data(contentsOf: URL(fileURLWithPath: path))
    return data
  }
}
