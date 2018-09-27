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

}
