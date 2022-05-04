//
//  ObserverTests.swift
//  MiniBootcampTests
//
//  Created by Abner Castro on 04/05/22.
//

import XCTest
@testable import MiniBootcamp

class ObserverTests: XCTestCase {
    
    func test_initializeWithAnyType_objectIsNil() {
            let sutString = Observer<String>()
            let sutInt = Observer<Int>(nil)
            let sutCustomClass = Observer<CustomTestClass>(nil)
            XCTAssertNotNil(sutString)
            XCTAssertNotNil(sutInt)
            XCTAssertNotNil(sutCustomClass)
        }
        
        func test_initializeWithAnyType_objectIsNotNil() {
            let sutString = Observer<String>(String())
            let sutInt = Observer<Int>(0)
            let sutCustomClass = Observer<CustomTestClass>(CustomTestClass())
            XCTAssertNotNil(sutString.value)
            XCTAssertNotNil(sutInt.value)
            XCTAssertNotNil(sutCustomClass.value)
        }
        
        func test_valueChange_throughSetter() {
            var sut = Observer<String>("Hola")
            sut.value = "Bye"
            XCTAssertEqual(sut.value, "Bye")
        }
        
        func test_valueChange_throughSetter_callListener() {
            var listenerCalled = false
            var sut = Observer<Bool>(false)
            sut.listener = { value in
                guard let value = value else { return }
                listenerCalled = value
            }
            sut.value = true
            XCTAssertTrue(listenerCalled)
        }
        
        func test_valueChanged_throughFunction_listenerIsCalled() {
            var listenerCalled = false
            var sut = Observer<Bool>(false)
            sut.listener = { value in
                guard let value = value else { return }
                listenerCalled = value
            }
            sut.onNext(true)
            XCTAssertTrue(listenerCalled)
            XCTAssertTrue(sut.value!)
        }
        
        func test_valueChanged_throughFunction_listenerIsNotCalled() {
            var listenerCalled = false
            var sut = Observer<Bool>(false)
            sut.listener = { value in
                guard let value = value else { return }
                listenerCalled = value
            }
            sut.changeBind(true)
            XCTAssertFalse(listenerCalled)
            XCTAssertTrue(sut.value!)
        }
        
        func test_listenerChanged_throughFunction() {
            var listenerCalled = false
            var sut = Observer<Bool>(false)
            sut.bind { value in
                guard let value = value else { return }
                listenerCalled = value
            }
            sut.onNext(true)
            XCTAssertTrue(listenerCalled)
        }
        
        private class CustomTestClass {}

}
