//
//  Main_pageUITests.swift
//  Femo1UITests
//

import XCTest

class Main_pageUITests: XCTestCase {

    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testResumeButtonIsHittable() {
        let app = XCUIApplication()
        let resumeGameButton = app.otherElements["Resume"]
        XCTAssertTrue(resumeGameButton.isHittable)

    }
    
    func testNewGameButtonIsHittable() {
        let app = XCUIApplication()
        let newGameButton = app.otherElements["New Game"]
        XCTAssertTrue(newGameButton.isHittable)
    }
    
}


