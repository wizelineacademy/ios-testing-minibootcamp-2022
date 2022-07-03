//
//  TweetViewModel.swift
//  MiniBootcamp
//
//  Created by Javier Cueto on 03/07/22.
//

struct TweetViewModel {
  let tweet: Tweet
  var name: String { tweet.user.name }
  var userName: String { tweet.user.nickname }
  var content: String { tweet.text }
}

