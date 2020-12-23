//
//  SantanderTaskUITests.swift
//  SantanderTaskUITests
//
//  Created by Farid Ullah on 16/12/2020.
//

import XCTest

class SantanderTaskUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // tap on the first collection view cell on the current screen
        let firstChild = app.collectionViews.children(matching: .any).element(boundBy: 0)
           if firstChild.exists {
               firstChild.tap()
           }
    }

    func testLaunchPerformance() throws {

    }
}