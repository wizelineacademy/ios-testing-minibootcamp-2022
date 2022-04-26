//
//  User.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 12/04/22.
//

import Foundation

struct User: Decodable {
    let name: String
    let nickname: String
    let description: String
    let location: String
    let followers: Int
    let creation: String
    let backgroundColor: String
    let profileImageURL: String?
    let coverImageURL: String?
}

extension User {
    
    private enum CodingKeys: String, CodingKey {
        case name
        case nickname = "screen_name"
        case description
        case location
        case followers = "followers_count"
        case creation = "created_at"
        case backgroundColor = "profile_background_color"
        case profileImageURL = "profile_image_url"
        case coverImageURL = "profile_background_image_url"
    }
    
}
