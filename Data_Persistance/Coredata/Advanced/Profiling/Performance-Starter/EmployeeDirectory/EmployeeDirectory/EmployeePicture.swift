//
//  EmployeePicture.swift
//  EmployeeDirectory
//
//  Created by Naresh on 20/05/18.
//  Copyright © 2018 Razeware. All rights reserved.
//

import Foundation
import CoreData
class EmployeePicture:NSManagedObject  {
  @NSManaged var picture:Data
  @NSManaged var employee:Employee
}
