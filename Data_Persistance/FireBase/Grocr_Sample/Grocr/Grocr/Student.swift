//
//  Student.swift
//  Grocr
//
//  Created by Naresh on 30/04/18.
//  Copyright © 2018 Razeware LLC. All rights reserved.
//

import Foundation

struct Student : Codable {
 
  init(name:String, standard:String, studentContacts:[StudentContact]?) {
    self.name = name
    self.standard = standard
    self.phoneArray = studentContacts
  }
  
  var name:String
  var standard:String
  var phoneArray:[StudentContact]?
}

extension FileManager {
  static var documentDirectoryURL: URL {
    return try! FileManager.default.url(
      for: .documentDirectory,
      in: .userDomainMask,
      appropriateFor: nil,
      create: false
    )
  }
}
