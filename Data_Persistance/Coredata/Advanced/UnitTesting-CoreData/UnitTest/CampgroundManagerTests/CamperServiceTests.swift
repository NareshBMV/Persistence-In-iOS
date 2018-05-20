/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import XCTest
import CampgroundManager
import CoreData

class CamperServiceTests: XCTestCase {

  // MARK: Properties
  var camparService: CamperService!
  var persistentContainer:NSPersistentContainer!
  
  override func setUp() {
    super.setUp()
    persistentContainer = NSPersistentContainer.testContainer()
    camparService = CamperService(managedObjectContext: persistentContainer.viewContext)
  }

  //Runs before and after each test runs (tearDown Method)
  override func tearDown() {
    super.tearDown()
    camparService = nil
    persistentContainer = nil
  }
  
  //1) Test that the camper is not nil and has attributes set
  func testAddCamper() {
    let camper = camparService.addCamper("Naresh", phoneNumber: "1111111111")
    XCTAssertNotNil(camper, "Camper should not be nil")
    XCTAssertTrue(camper?.fullName == "Naresh")
    XCTAssertTrue(camper?.phoneNumber == "1111111111")
  }
  
  //2) Test that the service automatically saves in the background
  func testContextIsSavedAfterAddingCamper() {
    let derivedContext = persistentContainer.newBackgroundContext()
    camparService = CamperService(managedObjectContext: derivedContext)
    
//  expecting derived object context to send notification on saving
    expectation(forNotification: NSNotification.Name.NSManagedObjectContextDidSave.rawValue, object: derivedContext) { (notification) -> Bool in
      return true
    }
    
    let _  = camparService.addCamper("Naresh", phoneNumber: "1111111111")
    
    waitForExpectations(timeout: 2.0) { (error) in
      XCTAssertNil(error, "Save did not occur")
    }
    
    //Wait for expectation to happen
    
  }
}
