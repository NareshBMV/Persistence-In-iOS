//
//  Pets+CoreDataProperties.swift
//  PetPal
//
//  Created by Naresh on 12/05/18.
//  Copyright © 2018 Razeware. All rights reserved.
//
//

import Foundation
import CoreData


extension Pets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pets> {
        return NSFetchRequest<Pets>(entityName: "Pets")
    }

    @NSManaged public var dob: NSDate?
    @NSManaged public var kind: String?
    @NSManaged public var name: String?
    @NSManaged public var picture: NSData?
    @NSManaged public var owner: Friend

}
