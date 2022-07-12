//
//  UserViewModel.swift
//  MiniBootcamp
//
//  Created by Juan David Torres on 14/06/22.
//

import Foundation

struct UserViewModel {
    private var user: User
}

extension UserViewModel {
    init(_ user: User) {
        self.user = user
    }
}

extension UserViewModel {
    var name: String {
        return self.user.name
    }
    
    var nickname: String {
        return self.user.nickname
    }
    
    var description: String {
        return self.user.description
    }
    
    var location: String {
        return self.user.location
    }
    
    var followers: Int {
        return self.user.followers
    }
    
    var creation: String {
        return self.user.creation
    }
    
    var backgroundColor: String {
        return self.user.backgroundColor
    }
    
    var profileImageURL: URL? {
        return URL(string: self.user.profileImageURL!)
    }
    
    var coverImageURL: String? {
        return self.user.coverImageURL
    }
    
}


