//
//  Tweet.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 12/04/22.
//

import Foundation

struct Tweet: Decodable {
    
    let creation: String
    let id: String
    let text: String
    let user: User
    let favs: Int
    let retweets: Int
}

extension Tweet {
    
    private enum CodingKeys: String, CodingKey {
        case creation = "created_at"
        case id = "id_str"
        case text
        case user
        case favs = "favorite_count"
        case retweets = "retweet_count"
    }
    
}
