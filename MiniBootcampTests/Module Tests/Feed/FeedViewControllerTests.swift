//
//  FeedViewControllerTests.swift
//  Mini bootcampTests
//
//  Created by Abner Castro on 07/04/22.
//

import XCTest
@testable import MiniBootcamp

class FeedViewControllerTests: XCTestCase {
    
    var sut: FeedViewController!
    
    override func setUp() {
        super.setUp()
        let viewModel = FeedViewModel(api: TweetTimelineAPI(session: FakeSession()))
        sut = FeedViewController(viewModel: viewModel)
        
        sut.loadViewIfNeeded()
    }
    
    func testInitWithCoder() {
        sut = FeedViewController(coder: NSCoder())
        XCTAssertNil(sut)
    }
    
    
    func test_hasTitle() {
        XCTAssertEqual(sut.title,"WizeTweet")
    }
    
    func test_vc_backgroundIsSystemBackground() {
        
        XCTAssertNotNil(sut.view?.backgroundColor)
        XCTAssertEqual(sut.view?.backgroundColor, .systemBackground)
    }
    
    
    func testViewControllerHasTableViewAsSubview() {
        XCTAssertEqual(sut.view.subviews.count, 0)
    }
    
    func testTableViewNumberOfRowsIsOne() {
        
        XCTAssertEqual(sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0), 0)
        
    }
    
    func testTableViewCell_cellIsTweetCell() {
        
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TweetCell
        
        XCTAssertNotNil(cell)
        
    }
    
    func test_rightBarButtonIsNotNil() {
        let rightButton = sut.navigationItem.rightBarButtonItem
        XCTAssertNotNil(rightButton)
    }
    
    func test_leftBarButtonIsNotNil() {
        let leftButton = sut.navigationItem.leftBarButtonItem
        XCTAssertNotNil(leftButton)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
}
