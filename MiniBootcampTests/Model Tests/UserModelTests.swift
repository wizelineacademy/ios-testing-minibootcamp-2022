//
//  UserModelTests.swift
//  Mini bootcampTests
//
//  Created by Abner Castro on 12/04/22.
//

import XCTest
@testable import MiniBootcamp

class UserModelTests: XCTestCase {
    
    func test_userModel_correctDecodeResponse() throws {
        
        guard let path = Bundle(for: type(of: self)).path(forResource: "userFake", ofType: "json") else { fatalError("Couldn't find user-fake.json file") }
        
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let sut = try JSONDecoder().decode(User.self, from: data)
        
        XCTAssertEqual(sut.name, "WizeBot")
        XCTAssertEqual(sut.nickname, "@wizebot")
        XCTAssertEqual(sut.description, "description")
        XCTAssertEqual(sut.location, "location")
        XCTAssertEqual(sut.followers, 100)
        XCTAssertEqual(sut.creation, "creation")
        XCTAssertEqual(sut.backgroundColor, "red")
        XCTAssertNotNil(sut.profileImageURL)
        XCTAssertNotNil(sut.coverImageURL)
    }
}
