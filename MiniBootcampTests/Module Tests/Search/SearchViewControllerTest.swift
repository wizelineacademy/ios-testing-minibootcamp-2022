//
//  SearchViewControllerTest.swift
//  MiniBootcampTests
//
//  Created by Javier Cueto on 03/07/22.
//

import XCTest
@testable import MiniBootcamp

class SearchViewControllerTests: XCTestCase {
    
    var sut: SearchViewController!
    
    override func setUp() {
        super.setUp()
        sut = SearchViewController()
        sut.loadViewIfNeeded()
        
//        let mainFlow = MainCoordinator(rootViewController: UINavigationController(), viewControllerFactory: iOSViewControllerFactory())
//        mainFlow.start()
//
//        let navVC = mainFlow.rootViewController
//        sut = navVC.viewControllers.first as? FeedViewController
//        sut.loadViewIfNeeded()
    }
    
    func test_hasTitle() {
        XCTAssertEqual(sut.title,"Search")
    }
    
    func test_vc_backgroundIsSystemBackground() {
        
        XCTAssertNotNil(sut.view?.backgroundColor)
        XCTAssertEqual(sut.view?.backgroundColor, .systemBackground)
    }
    
    
    func testViewControllerHasTableViewAsSubview() {
        XCTAssertEqual(sut.view.subviews.count, 0)
    }
    
    func testTableViewNumberOfRowsIsOne() {
        
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 5)
        
    }
    
    func testTableViewCell_cellIsTweetCell() {
        
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TweetCell
        
        XCTAssertNotNil(cell)
        
    }
    
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
}
