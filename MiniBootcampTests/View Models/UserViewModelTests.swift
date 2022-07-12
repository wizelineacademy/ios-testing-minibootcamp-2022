//
//  UserViewModelTests.swift
//  MiniBootcampTests
//
//  Created by Juan David Torres on 28/06/22.
//

import XCTest
@testable import MiniBootcamp
class UserViewModelTests: XCTestCase {

    var sut: UserViewModel!
    lazy var bundle = Bundle(for: self.classForCoder)
    
    func testCreateViewModelNotNilSut() {
        XCTAssertNotNil(sut)
    }
    
    func testCreateViewModelProperties() {
        XCTAssertNotNil(sut.profileImageURL)
        XCTAssertNotNil(sut.coverImageURL)
        XCTAssertNotNil(sut.nickname)
        XCTAssertNotNil(sut.backgroundColor)
        XCTAssertNotNil(sut.name)
        XCTAssertNotNil(sut.followers)
        XCTAssertNotNil(sut.location)
        XCTAssertNotNil(sut.description)
        XCTAssertNotNil(sut.creation)
        
        
        
    }
   

    override func setUpWithError() throws {
        let data = try Data.from(filename: "userFake", in: bundle, ofType: "json")!
        let user: User! = try JSONDecoder().decode(User.self, from: data)
        self.sut = UserViewModel(user)
        
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
