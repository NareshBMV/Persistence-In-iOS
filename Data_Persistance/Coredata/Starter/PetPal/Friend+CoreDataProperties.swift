//
//  Friend+CoreDataProperties.swift
//  PetPal
//
//  Created by Naresh on 08/05/18.
//  Copyright © 2018 Razeware. All rights reserved.
//
//

import Foundation
import CoreData


extension Friend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }
    @NSManaged public var name: String?
}
