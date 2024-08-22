//
//  RMCharacterViewControllerTestst.swift
//  Rick And MortyUITests
//
//  Created by Kevin Lagat on 22/08/2024.
//


import XCTest

class RMCharacterViewControllerTestst: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testSegmentedControlExists() {
        let segmentedControl = app.segmentedControls.element(boundBy: 0)
        XCTAssertTrue(segmentedControl.exists, "Segmented control should exist on the screen.")
    }

    func testTableViewExists() {
        let tableView = app.tables.element(boundBy: 0)
        XCTAssertTrue(tableView.exists, "Table view should exist on the screen.")
    }

    func testSegmentedControlSelectionChangesFilter() {
        let segmentedControl = app.segmentedControls.element(boundBy: 0)
        XCTAssertTrue(segmentedControl.buttons["Alive"].isSelected, "The 'Alive' segment should be selected initially.")
        segmentedControl.buttons["Dead"].tap()
        XCTAssertTrue(segmentedControl.buttons["Dead"].isSelected, "The 'Dead' segment should be selected after tapping.")
        segmentedControl.buttons["Unknown"].tap()
        XCTAssertTrue(segmentedControl.buttons["Unknown"].isSelected, "The 'Unknown' segment should be selected after tapping.")
    }

    func testCharactersLoadMoreButtonExists() {
        let tableView = app.tables.element(boundBy: 0)
        tableView.swipeUp()
        let loadMoreCell = tableView.cells.staticTexts["Load More"]
        XCTAssertTrue(loadMoreCell.exists, "The 'Load More' button should be present when there are more characters to load.")
    }

    func testCharacterCellTapOpensDetail() {
        let tableView = app.tables.element(boundBy: 0)
        let firstCell = tableView.cells.element(boundBy: 0)
        let exists = NSPredicate(format: "exists == 1")
        expectation(for: exists, evaluatedWith: firstCell, handler: nil)
        waitForExpectations(timeout: 10, handler: nil) // Increased timeout
        XCTAssertTrue(firstCell.exists, "The first character cell should exist.")
        firstCell.tap()
        let detailNavigationBar = app.navigationBars["Rick and Morty Character Details"]
        let detailViewExists = detailNavigationBar.waitForExistence(timeout: 10)
        XCTAssertTrue(detailViewExists, "Character detail view should be displayed after tapping a character cell.")
    }

    func testScrollTableView() {
        let tableView = app.tables.element(boundBy: 0)
        tableView.swipeUp()
        tableView.swipeDown()
        XCTAssertTrue(tableView.exists, "Table view should still exist after scrolling.")
    }
}

