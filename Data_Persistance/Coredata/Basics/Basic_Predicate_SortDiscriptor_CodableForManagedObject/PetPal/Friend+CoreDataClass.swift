//
//  Friend+CoreDataClass.swift
//  PetPal
//
//  Created by Naresh on 09/05/18.
//  Copyright © 2018 Razeware. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


//NSManagedObject - base class represents any core data entity or object ; notifies when object is deleted or saved
//Composed of two parts ; coredata properties and coredata class
//Coredata class - meant to hold custom code
//Coredata proerties - generated every time core data class is generated; code will be overridden when code changes in coredata class
//Managed Object Context - Data manager for adding and removing data to data store (SQLite internally)
//Persistence Container - To save the managed object to managed object context;Representation of coredata stack in application;Represents Data store

//NSFetchResultController - In addition to fetching necessary data; can optinally notified for data change of associated context with the delegate and update displayed UI; can also cache the data which is optional; can order data by section which is useful in displaying data in table or list view;

public class Friend: NSManagedObject,Decodable {
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case address = "Address"
        case dob = "dateOfBirth"
        case picture = "photo"
    }
    
    required convenience public init(from decoder: Decoder) throws {
        
        //Additional error check
        //        guard let contextUserInfoKey = CodingUserInfoKey.context,
        //            let managedObjectContext = decoder.userInfo[contextUserInfoKey] as? NSManagedObjectContext,
        //            let entity = NSEntityDescription.entity(forEntityName: ENTITY_NAME, in: managedObjectContext) else {
        //                fatalError("Failed to decode Friend!")
        //        }
        
        //Decodable code
        self.init(entity: Friend.entity(), insertInto: nil)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decode(String.self, forKey: .name)
        address = try values.decode(String.self, forKey: .address)
        dob = try values.decode(Date.self, forKey: .dob) as NSDate
//        picture = try values.decode(Data.self, forKey: .picture) as NSData

    }
    
    var age:Int{
        return Calendar.current.dateComponents([.year], from: (dob as Date?)!, to: Date()).year!
    }
}

extension Friend: Encodable {
    public func encode(to encoder: Encoder) throws {
        //Encoding to user keys
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(address, forKey: .address)
        try container.encode(dob! as Date, forKey: .dob)
        try container.encode(picture as Data?, forKey: .picture)

    }
}

extension CodingUserInfoKey {
    static let context = CodingUserInfoKey(rawValue: "context")
}


