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

public class Friend: NSManagedObject, Codable {
    
    required convenience public init(from decoder: Decoder) throws {
        self.init(entity: Friend.entity() , insertInto: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
    }
    
    var age:Int{
        return Calendar.current.dateComponents([.year], from: (dob as Date?)!, to: Date()).year!
    }
}

