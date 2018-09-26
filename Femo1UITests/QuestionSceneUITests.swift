//
//  QuestionSceneUITests.swift
//  Femo1UITests
//
//  Created by Farah Jabri on 26/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import XCTest

class QuestionSceneUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        app.otherElements["New Game"].tap()
        app.otherElements["Roll Dice"].tap()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testButton1IsHittable() {
        let app = XCUIApplication()
        let Button1 = app.buttons["button1Background"]
        XCTAssertTrue(Button1.isHittable)
    }

    
}
