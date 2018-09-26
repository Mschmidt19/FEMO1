//
//  GameSceneUITests.swift
//  Femo1UITests
//
//  Created by Farah Jabri on 26/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import XCTest

class GameSceneUITests: XCTestCase {
        
        override func setUp() {
            super.setUp()

            continueAfterFailure = false
            
            let app = XCUIApplication()
            app.launchArguments = ["enable-testing"]
            app.launch()
            app.otherElements["New Game"].tap()
            
        }
        
        override func tearDown() {
            super.tearDown()
        }
        
        func testnextTileButtonIsHittable() {
            let app = XCUIApplication()
            let nextTileButton = app.otherElements["Roll Dice"]
            XCTAssertTrue(nextTileButton.isHittable)
            
        }
    
        func testMenuButton(){
            let app = XCUIApplication()
            let menuButton = app.otherElements["Menu"]
            XCTAssertTrue(menuButton.isHittable)
        }
    
        func testInformationButton(){
            let app = XCUIApplication()
            let informationButton = app.otherElements["Information"]
            XCTAssertTrue(informationButton.isHittable)
        }
    
}
