//
//  InformationSceneUITests.swift
//  Femo1UITests
//
//  Created by Farah Jabri on 26/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import XCTest

class InformationSceneUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        app.otherElements["New Game"].tap()
        app.otherElements["Information"].tap()
    }
    
    override func tearDown() {

        super.tearDown()
    }
    
    func testMenuButton(){
        let app = XCUIApplication()
        let menuButton = app.otherElements["Menu"]
        XCTAssertTrue(menuButton.isHittable)
    }
    
    func testResumeButtonIsHittable() {
        let app = XCUIApplication()
        let resumeGameButton = app.otherElements["ResumeGame"]
        XCTAssertTrue(resumeGameButton.isHittable)
    }
    
}
