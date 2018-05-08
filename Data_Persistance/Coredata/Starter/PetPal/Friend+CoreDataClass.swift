//
//  Friend+CoreDataClass.swift
//  PetPal
//
//  Created by Naresh on 08/05/18.
//  Copyright © 2018 Razeware. All rights reserved.
//
//

import Foundation
import CoreData

//NSManagedObject - base class represents any core data entity or object ; notifies when object is deleted or saved
//Composed of two parts ; coredata properties and coredata class
//Coredata class - meant to hold custom code
//Coredata proerties - generated every time core data class is generated; code will be overridden when code changes in coredata class
//Managed Object Context - Data manager for adding and removing data to data store (SQLite internally)
//Persistence Container - To save the managed object to managed object context;Representation of coredata stack in application
public class Friend: NSManagedObject {

}
