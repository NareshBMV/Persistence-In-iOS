//
//  StudentContact.swift
//  Grocr
//
//  Created by Naresh on 30/04/18.
//  Copyright © 2018 Razeware LLC. All rights reserved.
//

import Foundation

class StudentContact:Codable {
  
  init(phone:String, network:String){
    self.phone = phone
    self.network = network
  }
  
  var phone:String?
  var network:String?
}
