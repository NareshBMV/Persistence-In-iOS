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
class OnlineUsersTableViewController: UITableViewController {
  
  // MARK: Constants
  let userCell = "UserCell"
  
  let userReference = Database.database().reference(withPath: "online")
  
  // MARK: Properties
  var currentUsers: [String] = []
  
  // MARK: UIViewController Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    //Updating all online users
    userReference.observe(.value) { (snapshot) in
      self.currentUsers.removeAll()
      if snapshot.exists() {
        for item in snapshot.children.allObjects as! [DataSnapshot] {
          self.currentUsers.append(item.value! as! String)
        }
        self.tableView.reloadData()
      }
    }
  }
  
  // MARK: UITableView Delegate methods
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return currentUsers.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: userCell, for: indexPath)
    let onlineUserEmail = currentUsers[indexPath.row]
    cell.textLabel?.text = onlineUserEmail
    return cell
  }
  
  // MARK: Actions
  
  @IBAction func signoutButtonPressed(_ sender: AnyObject) {
    //Sign out user
    try? Auth.auth().signOut()
    dismiss(animated: true, completion: nil)
  }
  
}
