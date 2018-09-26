//
//  MainPageUITesting.swift
//  Femo1UITests
//
//  Created by Farah Jabri on 26/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import XCTest

class MainPageUITesting: XCTestCase {
        
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
