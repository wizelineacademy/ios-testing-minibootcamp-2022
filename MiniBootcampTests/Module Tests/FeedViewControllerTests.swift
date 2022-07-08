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
    sut = FeedViewController()
    sut.loadViewIfNeeded()
  }

  override func tearDown() {
    sut = nil
    super.tearDown()
  }
    
  func test_vc_backgroundIsSystemBackground() {
    // Then
    XCTAssertNotNil(sut.view?.backgroundColor)
    XCTAssertEqual(sut.view?.backgroundColor, .white)
    }
    
    func testTableView_initialConfiguration() {
        XCTAssertFalse(sut.tableView.translatesAutoresizingMaskIntoConstraints)
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertNotNil(sut.tableView.delegate)
    }
    
    func testViewControllerHasTableViewAsSubview() {
        XCTAssertEqual(sut.view.subviews.count, 1)
    }
    
    func testTableViewNumberOfRowsIsOne() {
        
        XCTAssertEqual(sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0), 5)
        
    }
    
    func testTableViewCell_cellIsTweetCell() {
        
        let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TweetCell
        
        XCTAssertNotNil(cell)
        
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }

  func testTableViewInitialConfiguration() {
    XCTAssertFalse(sut.tableView.translatesAutoresizingMaskIntoConstraints)
    XCTAssertNotNil(sut.tableView.dataSource)
    XCTAssertNotNil(sut.tableView.delegate)
  }

  func testViewControllerHasTableViewAsSubview() {
    XCTAssert(sut.view.subviews.count > 0)
  }

  func testViewController_WhenDidLoad_StateIsLoading() {
    // TODO: - Test Loader
    // When
    sut.viewDidLoad()

    // Then
    XCTAssertEqual(sut.viewModel.state.value, .loading)
  }

  func testAddButton_isNotNil() throws {
    sut.viewDidLoad()
    let addTapButton: UIBarButtonItem = try XCTUnwrap(sut.navigationItem.rightBarButtonItem)
    XCTAssertNotNil(addTapButton)
  }

  func testViewControllerHasViewModel() {
    XCTAssertNotNil(sut.viewModel)
  }

  func testViewController_WhenDidLoad_ReloadsTableView() {
    // Given
    let expectation = expectation(description: "load tweets")
    let result = XCTWaiter.wait(for: [expectation], timeout: 8.0)
    // When
    sut.viewDidLoad()
    // Then
    if result == XCTWaiter.Result.timedOut {
      XCTAssertTrue((sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0))! > 0)
    } else {
      XCTFail("tableView was not reloaded")
    }
  }

  func test_addTappedButton_callsComposeTweet() {
    // Given
    let expectedCall = "composeTweet()"
    let coordinatorStub: CoordinatorStub = CoordinatorStub()
    sut.coordinator = coordinatorStub
    // When
    sut.addTapped()
    // Then
    print(coordinatorStub.calls.contains(expectedCall))
  }

  func test_showProfileButton_callsUserProfile() {
    // Given
    let expectedCall = "getUserProfile()"
    let coordinatorStub: CoordinatorStub = CoordinatorStub()
    sut.coordinator = coordinatorStub
    // When
    sut.showProfile()
    // Then
    print(coordinatorStub.calls.contains(expectedCall))
  }

  func testSomething() {
    var session = FakeSession()
    session.error = TweetAPIError.noData
    sut.viewModel.api = TweetTimelineAPI(session: session)
    sut.viewDidLoad()

    print("SOME")
  }

  // MARK: - Profile Unit Tests
  func test_showProfileButton_isNotNil() throws {
    // Given
    let profileButton: UIBarButtonItem = try XCTUnwrap(sut.navigationItem.leftBarButtonItem)
    // Then
    XCTAssertNotNil(profileButton)
  }
}
