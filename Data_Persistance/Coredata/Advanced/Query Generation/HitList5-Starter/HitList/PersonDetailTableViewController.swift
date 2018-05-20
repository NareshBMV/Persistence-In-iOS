//
//  PersonDetailTableViewController.swift
//  HitList
//
//  Created by Luke Parham on 11/3/16.
//  Copyright © 2016 Razeware. All rights reserved.
//

import UIKit
import CoreData

class PersonDetailTableViewController: UITableViewController {
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var addressTextField: UITextField!
  @IBOutlet weak var ageTextField: UITextField!

  var personID:NSManagedObjectID?
  var managedObjectContext: NSManagedObjectContext?
  var person: Person!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let filterBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(PersonDetailTableViewController.save))
    navigationItem.rightBarButtonItem = filterBarButtonItem
    
    if let managedObjectContext = managedObjectContext,
      let personID = personID {
      person = managedObjectContext.object(with: personID) as! Person
      nameTextField.text = person.name
      addressTextField.text = person.address
    }
  }
  
  func save() {
    if let name = nameTextField.text,
      let address = addressTextField.text,
      let age = ageTextField.text {
      
      if !name.isEmpty {
        person.name = name
      }
      
      if !address.isEmpty {
        person.address = address
      }
      
      if !age.isEmpty {
        person.age = Int16(age) ?? person.age
      }
      if person.hasChanges {
        do {
          try managedObjectContext?.save()
        } catch let error {
          print(error)
        }
      }
    }
    let _ = navigationController?.popViewController(animated: true)
  }
  
  
}
