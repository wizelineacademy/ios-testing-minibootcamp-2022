//
//  UserProfile.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 07/07/22.
//

import Foundation

struct UserProfile {
  let name: String
  let nickname: String
  let description: String
  let location: String
  let followers: String
  let creation: String
  var backgroundColor: String
  var profileImageData: Data?
  var coverImageData: Data?

  init(from user: User) {
    self.name = user.name
    self.nickname = user.nickname
    self.description = user.description
    self.location = user.location
    self.followers = String(user.followers)
    self.creation = user.creation
    self.backgroundColor = user.backgroundColor
  }
}
