//
//  TweetListViewModel.swift
//  MiniBootcamp
//
//  Created by Juan David Torres on 14/06/22.
//

import Foundation

struct TweetListViewModel {
    private var tweetList: [Tweet]
}

extension TweetListViewModel {
    init(_ tweetList: [Tweet]) {
        self.tweetList = tweetList
    }
}

extension TweetListViewModel {
    var numberOfRows: Int {
        return self.tweetList.count
    }
    
    func tweetAtIndex(index: Int) -> TweetViewModel {
        return TweetViewModel(self.tweetList[index])
    }
    
    func getListTweets() -> [TweetViewModel] {
        var tweetsViewModel: [TweetViewModel] = []
        for tweet in tweetList {
            tweetsViewModel.append(TweetViewModel(tweet))
        }
        return tweetsViewModel
    }
}
