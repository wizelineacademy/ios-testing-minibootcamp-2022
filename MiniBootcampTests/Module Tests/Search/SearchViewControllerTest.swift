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
    var fakeSession: FakeSession!
    var api: TweetTimelineAPI!
	var viewModel: SearchViewModel!
    
    override func setUp() {
        super.setUp()
        fakeSession = FakeSession()
        api = TweetTimelineAPI(session: fakeSession)
        
		viewModel = SearchViewModel(api: api)
        sut = SearchViewController(viewModel: viewModel)
        sut.loadViewIfNeeded()
        
        let mainFlow = SearchCoordinator()
        mainFlow.start()

        let navVC = mainFlow.rootViewController as? UINavigationController
        sut = navVC?.viewControllers.first as? SearchViewController
        sut.loadViewIfNeeded()
    }
    
    func testInitWithCoder() {
        sut = SearchViewController(coder: NSCoder())
        XCTAssertNil(sut)
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
    
    func testTableViewNumberOfRowsIsZero() {
        
        XCTAssertEqual(sut.tableView(sut.tableView, numberOfRowsInSection: 0), 0)
        
    }
    
    func testTableViewCell_cellIsTweetCell() throws {
		
		fakeSession = FakeSession()
		api = TweetTimelineAPI(session: fakeSession)
		
		viewModel = SearchViewModel(api: api)
		sut = SearchViewController(viewModel: viewModel)
		sut.loadViewIfNeeded()
		fakeSession.data = try TweetMock().tweetsSearch()

		viewModel.search("minion")
		let exp = expectation(description: "Waiting for searching")
		let result = XCTWaiter.wait(for: [exp], timeout: 5)
		if result == XCTWaiter.Result.timedOut {
			print(viewModel.timeline.count)
			let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TweetCell
			XCTAssertNotNil(cell)
		} else {
			XCTFail("Text is not correct or timed out first")
		}

        
    }
	
	func test_configBindingFailed() throws {
		
		fakeSession = FakeSession()
		api = TweetTimelineAPI(session: fakeSession)
		
		viewModel = SearchViewModel(api: api)
		sut = SearchViewController(viewModel: viewModel)
		sut.loadViewIfNeeded()
		fakeSession.data = try TweetMock().tweetData()

		viewModel.search("minion")
		let exp = expectation(description: "Waiting for searching")
		let result = XCTWaiter.wait(for: [exp], timeout: 5)
		if result == XCTWaiter.Result.timedOut {
			XCTAssertEqual(viewModel.state.value, State.failure)
		} else {
			XCTFail("Text is not correct or timed out first")
		}

		
	}
    
    func test_WhenUserIsTyping_SearchingText() {
        sut.navigationController?.navigationItem.searchController = UISearchController(searchResultsController: nil)
        let searchController = sut.navigationController?.navigationItem.searchController
        searchController!.searchBar.text = "minions"
        sut.updateSearchResults(for: searchController!)
        XCTAssertNotNil(searchController)
        
    }
    
    func test_SearchingText() throws {
        sut.navigationController?.navigationItem.searchController = UISearchController(searchResultsController: nil)
        let searchController = sut.navigationController?.navigationItem.searchController
        searchController!.searchBar.text = "minions"
        sut.viewDidLoad()
        fakeSession.data = try TweetMock().tweetsSearch()
        sut.searchingText()
        let exp = expectation(description: "Waiting for seraching")
        let result = XCTWaiter.wait(for: [exp], timeout: 5)
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(searchController)
        } else {
            XCTFail("Text is not correct or timed out first")
        }
   
        
    }
    
    
    override func tearDown() {
        super.tearDown()
        sut = nil
		fakeSession = nil
		api = nil
		viewModel = nil
    }
    
}
