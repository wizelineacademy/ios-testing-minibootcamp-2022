//
//  SearchViewModelTests.swift
//  MiniBootcampTests
//
//  Created by Javier Cueto on 04/07/22.
//

import XCTest
@testable import MiniBootcamp

class SearchViewModelTests: XCTestCase {

    var sut: SearchViewModel!
    var fakeSession: FakeSession!
    var api: TweetTimelineAPI!
    
    override func setUp() {
        super.setUp()
        fakeSession = FakeSession()
        api = TweetTimelineAPI(session: fakeSession)
        sut = SearchViewModel(api: api)
    }
    
    func testHasTitle() {
        XCTAssertNotNil(sut.title)
    }
    
    func testNumberOfRowsGreaterOrEqualZero() {
        XCTAssertGreaterThanOrEqual(sut.timeline.count, 0)
    }
    
    func test_initialState_stateIsNil() {
        let state = sut.state.value
        XCTAssertNil(state)
    }
    
    func test_whenSearchIsRequested_stateIsLoading() {
        let text = "minions"
        
        sut.search(text)
        let state = sut.state.value
        
        XCTAssertEqual(state, .loading)
    }
    
    func test_whenSearchIsRequested_stateHasFailed() throws {
        fakeSession.data = try TweetMock().tweetData()
        let text = "minions"
        let expec = expectation(description: "search expectation")
        sut.state.bind { state in
            switch state {
            case .failure:
                expec.fulfill()
            default:
                break
            }
        }
        
        sut.search(text)
        wait(for: [expec], timeout: 4)
        let state = sut.state.value
        
        XCTAssertEqual(state, .failure)
    }
    
    func test_whenSearchIsRequested_stateIsSuccess() throws {
        let text = "minions"
        fakeSession.data = try TweetMock().tweetsData()
        let expect = expectation(description: "search succeed")
        sut.state.bind { state in
            switch state {
            case .success:
                expect.fulfill()
            default:
                break
            }
        }
        
        sut.search(text)
        wait(for: [expect], timeout: 4)
        let state = sut.state.value
        XCTAssertEqual(state, .success)
    }
    
    func test_whenStateSuccess_searchHasData() throws {
        let text = "minions"
        fakeSession.data = try TweetMock().tweetsData()
        let expect = expectation(description: "search has data")
        sut.state.bind { state in
            switch state {
            case .success:
                expect.fulfill()
            default:
                break
            }
        }
        sut.search(text)
        wait(for: [expect], timeout: 4)
        let data = sut.timeline.count
        XCTAssertGreaterThan(data, 0)
    }
    
    func test_whenStateNotChange_keywordIsEmpty() {
        let text = ""
        sut.search(text)
        let state = sut.state.value
        XCTAssertNil(state)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        fakeSession = nil
        api = nil
    }

}
