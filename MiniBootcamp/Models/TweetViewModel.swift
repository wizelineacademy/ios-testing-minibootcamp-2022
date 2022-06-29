//
//  TweetViewModel.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 28/06/22.
//

import Foundation

struct TweetViewModel {
  let tweet: Tweet
  var name: String { tweet.user.name }
  var userName: String { tweet.user.nickname }
  var content: String { tweet.text }
}
