//
//  QuestionSceneUITests.swift
//  Femo1UITests
//
//  Created by Marek Schmidt on 9/26/18.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import XCTest

class QuestionSceneUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
//        XCUIApplication().launch()
        
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        app.otherElements["New Game"].tap()
        
        

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAnswer1ButtonIsHittable() {
        let app = XCUIApplication()
        let button1Text = app.buttons["button1Text"]
        let button1Background = app.buttons["button1Background"]
        XCTAssertTrue(button1Text.isHittable)
        XCTAssertTrue(button1Background.isHittable)
    }
    
    func testAnswer2ButtonIsHittable() {
        let app = XCUIApplication()
        let button2Text = app.buttons["button2Text"]
        let button2Background = app.buttons["button2Background"]
        XCTAssertTrue(button2Text.isHittable)
        XCTAssertTrue(button2Background.isHittable)
    }
    
    func testAnswer3ButtonIsHittable() {
        let app = XCUIApplication()
        let button3Text = app.buttons["button3Text"]
        let button3Background = app.buttons["button3Background"]
        XCTAssertTrue(button3Text.isHittable)
        XCTAssertTrue(button3Background.isHittable)
    }
    
    func testAnswer4ButtonIsHittable() {
        let app = XCUIApplication()
        let button4Text = app.buttons["button4Text"]
        let button4Background = app.buttons["button4Background"]
        XCTAssertTrue(button4Text.isHittable)
        XCTAssertTrue(button4Background.isHittable)
    }

}
