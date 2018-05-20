//
//  TestPersistentContainer.swift
//  CampgroundManagerTests
//
//  Created by Naresh on 19/05/18.
//  Copyright © 2018 Razeware. All rights reserved.
//

import Foundation
import CoreData
extension NSPersistentContainer {
  class func testContainer()->NSPersistentContainer {
    let container = NSPersistentContainer(name: "CampgroundManager")
    let persistentStoreDescription = NSPersistentStoreDescription()
    //None of the data will persist after the test run
    persistentStoreDescription.type = NSInMemoryStoreType
    container.persistentStoreDescriptions = [persistentStoreDescription]
    container.loadPersistentStores { (storeDesctiption, error) in
      print(storeDesctiption)
      if let err = error {
        fatalError("\(err)")
      }
    }
    container.viewContext.automaticallyMergesChangesFromParent = true
    return container
  }
}
