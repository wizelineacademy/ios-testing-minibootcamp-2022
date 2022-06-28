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

  func testTableViewInitialConfiguration() {
    XCTAssertFalse(sut.tableView.translatesAutoresizingMaskIntoConstraints)
    XCTAssertNotNil(sut.tableView.dataSource)
    XCTAssertNotNil(sut.tableView.delegate)
  }

  func testViewControllerHasTableViewAsSubview() {
    XCTAssertEqual(sut.view.subviews.count, 1)
  }

  func testViewController_WhenDidLoad_StateIsLoading() {
    // TODO: - Test Loader
    // When
    sut.viewDidLoad()

    // Then
    XCTAssertEqual(sut.viewModel.state.value, .loading)
  }

  func testTableViewCell_cellIsTweetCell() {
    // TODO: - Add TDD
//    let cell = sut.tableView.dataSource?.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? TweetCell
//    XCTAssertNotNil(cell)
  }

  func testAddButtonTapped_PrintsEmptyString() {
    sut.viewDidLoad()
  }

  func testViewControllerHasViewModel() {
    XCTAssertNotNil(sut.viewModel)
  }

  func testViewController_WhenDidLoad_ReloadsTableView() {
    // Given
    let expectation = expectation(description: "load tweets")
    let result = XCTWaiter.wait(for: [expectation], timeout: 5.0)

    // Then
    if result == XCTWaiter.Result.timedOut {
      XCTAssertTrue((sut.tableView.dataSource?.tableView(sut.tableView, numberOfRowsInSection: 0))! > 0)
    } else {
      XCTFail("tableView was not reloaded")
    }
  }

  // MARK: -
}
