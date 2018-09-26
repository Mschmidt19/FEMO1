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
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testthisbutton(){
  
        
        let app = XCUIApplication()
        app.otherElements["New Game"].tap()
        
        let rollDiceElement = app.otherElements["Roll Dice"]
        rollDiceElement.tap()
        app.otherElements["Groovy"].tap()
        rollDiceElement.tap()
        app.otherElements["RSpec"].tap()
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.tap()
        app.otherElements["Internet Protocol"].tap()
        rollDiceElement.tap()
        app.otherElements["Personal Home Page"].tap()
        rollDiceElement.tap()
        app.otherElements["Ruby"].tap()
 
        
    }
    
    
}
