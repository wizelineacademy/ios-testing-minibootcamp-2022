//
//  StaticFuncsTests.swift
//  Mini bootcampTests
//
//  Created by Abner Castro on 08/04/22.
//

import XCTest
@testable import MiniBootcamp

class StaticFuncsTests: XCTestCase {
    
    func test_createFunction() {
        let text = "This is a text test for create"
        let sut: UILabel = create {
            $0.text = text
        }
        XCTAssertEqual(sut.text, text)
    }
}
