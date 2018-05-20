///**
// * Copyright (c) 2016 Razeware LLC
// *
// * Permission is hereby granted, free of charge, to any person obtaining a copy
// * of this software and associated documentation files (the "Software"), to deal
// * in the Software without restriction, including without limitation the rights
// * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// * copies of the Software, and to permit persons to whom the Software is
// * furnished to do so, subject to the following conditions:
// *
// * The above copyright notice and this permission notice shall be included in
// * all copies or substantial portions of the Software.
// *
// * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// * THE SOFTWARE.
// */
//
import UIKit
import XCTest
import CampgroundManager
import CoreData

class CampSiteServiceTests: XCTestCase {

  // MARK: Properties
  var campSiteService: CampSiteService!
  var persistentContainer: NSPersistentContainer!

  override func setUp() {
    super.setUp()
    persistentContainer = NSPersistentContainer.testContainer()
    campSiteService = CampSiteService(managedObjectContext: persistentContainer.viewContext)
  }

  override func tearDown() {
    super.tearDown()

    persistentContainer = nil
    campSiteService = nil
  }

//  func testRootContextIsSavedAfterAddingCampsite() {
//    let derivedContext = persistentContainer.newBackgroundContext()
//
//    campSiteService = CampSiteService(managedObjectContext: derivedContext )
//
//    expectation(
//      forNotification: NSNotification.Name.NSManagedObjectContextDidSave.rawValue,
//      object: derivedContext) { notification in
//        return true
//    }
//
//    let campSite = campSiteService.addCampSite(1, electricity: true, water: true)
//    XCTAssertNotNil(campSite)
//
//    waitForExpectations(timeout: 2.0) { error in
//      XCTAssertNil(error, "Save did not occur")
//    }
//  }
//
//  func testAddCampSite() {
//    let campSite = campSiteService.addCampSite(1, electricity: true, water: true)
//
//    XCTAssertTrue(campSite.siteNumber == 1, "Site number should be 1")
//    XCTAssertTrue(campSite.electricity!.boolValue, "Site should have electricity")
//    XCTAssertTrue(campSite.water!.boolValue, "Site should have water")
//  }
//
//  func testGetCampSiteWithMatchingSiteNumber() {
//    _ = campSiteService.addCampSite(1, electricity: true, water: true)
//
//    let campSite = campSiteService.getCampSite(1)
//    XCTAssertNotNil(campSite, "A campsite should be returned")
//  }
//
//  func testGetCampSiteNoMatchingSiteNumber() {
//    _ = campSiteService.addCampSite(1, electricity: true, water: true)
//
//    let campSite = campSiteService.getCampSite(2)
//    XCTAssertNil(campSite, "No campsite should be returned")
//  }
  
  func testDeleteCampSite() {
    _ = campSiteService.addCampSite(1, electricity: true, water: true)
    var fetchCampsiteService = campSiteService.getCampSite(1)
    XCTAssertNotNil(fetchCampsiteService, "Site should exists")
    campSiteService.deleteCampSite(1)
    fetchCampsiteService = campSiteService.getCampSite(1)
    XCTAssertNil(fetchCampsiteService, "Site Shouldnt exists")
  }
  
  func testGetNextCampSiteNumberOneSiteGapFrom1()
  {
    _ = campSiteService.addCampSite(11, electricity: true, water: true)
    let siteNumber = campSiteService.getNextCampSiteNumber()
    XCTAssertTrue(siteNumber.intValue == 12)
  }
}
