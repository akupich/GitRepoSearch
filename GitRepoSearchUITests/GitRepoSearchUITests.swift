//
//  GitRepoSearchUITests.swift
//  GitRepoSearchUITests
//
//  Created by Andriy Kupich on 13.09.2021.
//

import XCTest

class GitRepoSearchUITests: XCTestCase {
    
    private let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        
        app.launchArguments = ["testMode"]
        app.launch()
    }

    func testSearchResultsAreDisplayed() throws {
        XCTAssertTrue(app.cells.count == 0)
        
        search(for: "afn", inside: app)
        
        _ = app.cells["searchCell"].waitForExistence(timeout: 5)
        XCTAssertTrue(app.cells.count == 1, "Search results expected to return 1 repository")
    }
    
    func testTapOnCellOpeningSafariBrowser() throws {
        // Arrange
        let safari = XCUIApplication(bundleIdentifier: "com.apple.mobilesafari")
        
        // Act
        search(for: "afn", inside: app)
        app.cells.firstMatch.tap()
        
        // Assert
        let isBrowserOpened = safari.wait(for: .runningForeground, timeout: 5)
        XCTAssertTrue(isBrowserOpened, "Safari should be opened when tapped on repository")
    }
    
    private func search(for text: String, inside app: XCUIApplication) {
        let nameTextField = app.textFields["searchTextField"]
        nameTextField.tap()
        nameTextField.typeText(text)
    }
}
