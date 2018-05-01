/*
 * Copyright (c) 2015 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import Firebase

class GroceryListTableViewController: UITableViewController {

  // MARK: Constants
  let listToUsers = "ListToUsers"
  
  // MARK: Properties 
  var items: [GroceryItem] = []
  var user: User!
  var userCountBarButtonItem: UIBarButtonItem!
  var groceryItemsReference = Database.database().reference(withPath: "grocery-Items")
  var userReference = Database.database().reference(withPath: "online")

  // MARK: UIViewController Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    tableView.allowsMultipleSelectionDuringEditing = false
    
    userCountBarButtonItem = UIBarButtonItem(title: "1",
                                             style: .plain,
                                             target: self,
                                             action: #selector(userCountButtonDidTouch))
    userCountBarButtonItem.tintColor = UIColor.white
    navigationItem.leftBarButtonItem = userCountBarButtonItem
    
    //Fetching child data snapshot and displaying in the table view
    groceryItemsReference.observe(.value, with:{ snapshot in
      var dataArray:[GroceryItem] = []
      for item in snapshot.children {
        let groceryItem = GroceryItem(snapshot: item as! DataSnapshot)
        dataArray.append(groceryItem)
      }
      
      self.items = dataArray
      self.tableView.reloadData()
    })
    
    groceryItemsReference.child("pizza").observe(.value) {
      snapshot in
      let values = snapshot.value as! [String:AnyObject]
      print(values)
      let name = values["name"] as! String
      let user = values["addedByUSer"] as! String
      let completed = values["completed"] as! Bool
      print("Name : \(name)")
      print("User : \(user)")
      print("Completed : \(completed)")
    }
    
    //Querying to get data
    groceryItemsReference.queryOrdered(byChild: "completed").observe(.value){
      snapshot in
      var groceryItems:[GroceryItem] = []
      for items in snapshot.children {
        let grocery = GroceryItem(snapshot: items as! DataSnapshot)
        groceryItems.append(grocery)
      }
      self.items = groceryItems
      self.tableView.reloadData()
    }
    
    Auth.auth().addStateDidChangeListener { (auth, user) in
      if let user = user {
        self.user = User(uid: user.uid, email: user.email!)
        let currentUserReference = self.userReference.child(self.user.uid)
        currentUserReference.ref.setValue(self.user.email)
        currentUserReference.onDisconnectRemoveValue()
      }
    }
    
    userReference.observe(.value) { (snapshot) in
      if snapshot.exists() {
        self.userCountBarButtonItem.title = snapshot.childrenCount.description
      }else {
        self.userCountBarButtonItem.title = "0"
      }
    }
  }
  
  
  // MARK: UITableView Delegate methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
    let groceryItem = items[indexPath.row]
    
    cell.textLabel?.text = groceryItem.name
    cell.detailTextLabel?.text = groceryItem.addedByUser
    
    toggleCellCheckbox(cell, isCompleted: groceryItem.completed)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      
      //Removing Item from firebase database
      let groceryItem = items[indexPath.row]
      groceryItem.ref?.removeValue()
      //alternate way to delete value by setting nil
//      groceryItem.ref?.setValue(nil)
      
      items.remove(at: indexPath.row)
      tableView.reloadData()
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let cell = tableView.cellForRow(at: indexPath) else { return }
    var groceryItem = items[indexPath.row]
    let toggledCompletion = !groceryItem.completed

    toggleCellCheckbox(cell, isCompleted: toggledCompletion)
    groceryItem.completed = toggledCompletion
    
    //Updating completed bool value from firebase database
    let values:[String:Any] = ["completed":toggledCompletion]
    groceryItem.ref?.updateChildValues(values)
    
    //Updating name in firebase database
//    let values:[String:Any] = ["name":"Beacon"]
//    groceryItem.ref?.updateChildValues(values)
    tableView.reloadData()
  }
  
  func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
    if !isCompleted {
      cell.accessoryType = .none
      cell.textLabel?.textColor = UIColor.black
      cell.detailTextLabel?.textColor = UIColor.black
    } else {
      cell.accessoryType = .checkmark
      cell.textLabel?.textColor = UIColor.gray
      cell.detailTextLabel?.textColor = UIColor.gray
    }
  }
  
  // MARK: Add Item
  
  @IBAction func addButtonDidTouch(_ sender: AnyObject) {
    let alert = UIAlertController(title: "Grocery Item",
                                  message: "Add an Item",
                                  preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save",
                                   style: .default) { action in
      let textField = alert.textFields![0]
      let groceryItem = GroceryItem(name: textField.text!,
                                    addedByUser: self.user.email,
                                    completed: false)
        
      self.items.append(groceryItem)
      self.tableView.reloadData()
                                    
       let groceryItemRef = self.groceryItemsReference.child((textField.text?.lowercased())!)
       let values:[String:Any] = ["name":textField.text!.lowercased(), "addedByUSer":self.user.email, "completed":false]
      groceryItemRef.setValue(values)
    }
    
    let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .default)
    
    alert.addTextField()
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    
    present(alert, animated: true, completion: nil)
  }
  
  @objc func userCountButtonDidTouch() {
    //Signout method call on auth
//    try! Auth.auth().signOut()
    performSegue(withIdentifier: listToUsers, sender: nil)
  }
  
}
