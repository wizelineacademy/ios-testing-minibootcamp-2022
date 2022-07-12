//
//  TweetViewModel.swift
//  MiniBootcamp
//
//  Created by Juan David Torres on 14/06/22.
//

import Foundation

struct TweetViewModel {
    private var tweet: Tweet
}

extension TweetViewModel {
    init(_ tweet: Tweet) {
        self.tweet = tweet
    }
}
//let creation: String
//let id: String
//let text: String
//let user: User
//let favs: Int
//let retweets: Int
extension TweetViewModel {
    var creation: String {
        self.tweet.creation
    }
    
    var id: String {
        self.tweet.id
    }
    
    var text: String {
        self.tweet.text
    }
    
    var user: User {
        self.tweet.user
    }
    
    var favs: Int {
        self.tweet.favs
    }
    
    var retweets: Int {
        self.tweet.retweets
    }
    
}
