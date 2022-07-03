//
//  FeedViewModel.swift
//  MiniBootcamp
//
//  Created by Javier Cueto on 03/07/22.
//

final class FeedViewModel {
    var api: TweetTimelineAPI
    var state: Observer<State> = Observer<State>()
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
            case .failure(_):
                self.state.value = .failure
            }
        }
    }
}