//
//  ViewModel.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 28/06/22.
//

import Foundation

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

