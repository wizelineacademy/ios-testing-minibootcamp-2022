//
//  ViewModel.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 28/06/22.
//

import Foundation

enum TweetState {
  case loading
  case success
  case failure
}

struct TweetViewModel {
  var name: String { tweet.user.name }
  var userName: String { tweet.user.nickname }
  let tweet: Tweet
  var content: String { tweet.text }
}

class ViewModel {
  var api: TweetTimelineAPI
  var state: Observer<TweetState> = Observer<TweetState>()
  var timeline: [TweetViewModel] = []

  init(api: TweetTimelineAPI) {
    self.api = api
  }


  func fetchTweetTimeLine() {
    state.value = .loading
    api.load(.timeline) { result in
      switch result {
      case .success(let tweets):
        for tweet in tweets {
          self.timeline.append(TweetViewModel(tweet: tweet))
        }
        self.state.value = .success
      case .failure(let error):
        self.state.value = .failure
      }
    }
  }
}

