//
//  QuestionsUITesting.swift
//  Femo1UITests
//
//  Created by Farah Jabri on 26/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import XCTest

class QuestionsUITesting: XCTestCase {
        
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
