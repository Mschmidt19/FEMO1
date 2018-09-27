//
//  Femo1UITests.swift
//  Femo1UITests
//
//  Created by Farah Jabri on 25/09/2018.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import XCTest
@testable import Femo1

class Femo1UITests: XCTestCase {
    
    
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
    
    func testHello() {
        
        
        let app = XCUIApplication()
        app.buttons["NewGame"].tap()
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element
        element.tap()
        app.buttons["ResumeGameText"].tap()
        app.buttons["nextTileButton"].tap()
        element.tap()
        element.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Play_button"]/*[[".otherElements[\"InformationScene\"].buttons[\"Play_button\"]",".buttons[\"Play_button\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        element.tap()

        
    }

}
