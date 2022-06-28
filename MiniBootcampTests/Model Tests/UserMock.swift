//
//  UserMock.swift
//  MiniBootcampTests
//
//  Created by Abner Castro on 28/06/22.
//

import Foundation
@testable import MiniBootcamp

class UserStub {
    
    func tweetStub() throws -> User {
        guard let path = Bundle(for: type(of: self)).path(forResource: "userFake", ofType: "json") else { fatalError("Couldn't find user-fake.json file") }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        return try JSONDecoder().decode(User.self, from: data)
    }
    
}
