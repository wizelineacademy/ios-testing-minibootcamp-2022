//
//  ComposeTweetViewModel.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 02/07/22.
//

import Foundation

class ComposeTweetViewModel {
  var api: PostTweetAPI
  var state: Observer<TweetState> = Observer<TweetState>()

  init(api: PostTweetAPI) {
    self.api = api
  }

  func postTweet() {
    state.value = .loading
    api.send(.postTweet) { result in
      switch result {
      case .success(let tweets):
        self.state.value = .success
        print(tweets)
      case .failure(let error):
        self.state.value = .failure
        print(error)
      }
    }
  }
}
