//
//  Main_pageUITests.swift
//  Femo1UITests
//
//  Created by Marek Schmidt on 9/26/18.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//

import XCTest

class Main_pageUITests: XCTestCase {

    //
    //  Femo1UITests.swift
    //  Femo1UITests
    //
    //  Created by Farah Jabri on 25/09/2018.
    //  Copyright © 2018 FEMO@Makers. All rights reserved.
    //
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        //        XCUIApplication().launch()
        
        let app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testResumeButtonIsHittable() {
        let app = XCUIApplication()
        let newGameButton = app.otherElements["Resume"]
        XCTAssertTrue(newGameButton.isHittable)
    }
    
    func testNewGameButtonIsHittable() {
        let app = XCUIApplication()
        let newGameButton = app.otherElements["New Game"]
        XCTAssertTrue(newGameButton.isHittable)
    }
        
}

