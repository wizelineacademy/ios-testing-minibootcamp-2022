//
//  TweetMock.swift
//  MiniBootcampTests
//
//  Created by Abner Castro on 28/06/22.
//

import Foundation
@testable import MiniBootcamp

class TweetStub {
    
    func tweetStub() throws -> Tweet {
        guard let path = Bundle(for: type(of: self)).path(forResource: "tweetFake", ofType: "json") else { fatalError("Couldn't find tweetFake.json file") }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        print(try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed))
        return try JSONDecoder().decode(Tweet.self, from: data)
    }
    
    func tweets(number: Int) throws -> [Tweet] {
        var timeline = [Tweet]()
        for _ in 1...number {
            timeline.append(try tweetStub())
        }
        return timeline
    }
    
}
