//
//  MelbourneBikeTests.swift
//  MelbourneBikeTests
//
//  Created by Kenan Karakecili on 20/11/16.
//  Copyright © 2016 Kenan Karakecili. All rights reserved.
//

import XCTest
@testable import MelbourneBike

class MelbourneBikeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
  func testGetSpots() {
    let myExpectation = expectation(description: "There are no bike spots!")
    MBAPI.getSpots { (bikeSpots) in
      if bikeSpots.count > 0 {
        myExpectation.fulfill()
      } else {
        XCTFail()
      }
    }
    waitForExpectations(timeout: 10, handler: nil)
  }
    
}
