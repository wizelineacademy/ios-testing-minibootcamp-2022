//
//  WrapperTests.swift
//  MiniBootcampTests
//
//  Created by Heber Raziel Alvarez Ruedas on 16/06/22.
//

import Foundation

import XCTest
@testable import MiniBootcamp

class WrapperTests: XCTestCase {

  var sut: UsesLayout<UIView>!

  override func setUp() {
    sut = UsesLayout(wrappedValue: UIView())
    super.setUp()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }


  func testAutoLayoutWrapperReturnsFalse() {
    XCTAssertFalse(sut.wrappedValue.translatesAutoresizingMaskIntoConstraints)
  }

  func testAutoLayoutDidSetWrapperReturnsFalse() {
    sut.wrappedValue = UIButton()
    XCTAssertFalse(sut.wrappedValue.translatesAutoresizingMaskIntoConstraints)
  }


}
