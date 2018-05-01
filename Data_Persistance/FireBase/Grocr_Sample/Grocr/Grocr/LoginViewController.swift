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

class LoginViewController: UIViewController {
  
  // MARK: Constants
  let loginToList = "LoginToList"
  // MARK: Outlets
  @IBOutlet weak var textFieldLoginEmail: UITextField!
  @IBOutlet weak var textFieldLoginPassword: UITextField!
  
  
  override func viewDidLoad() {
    //Working with References in FireBase
    let rootRef = Database.database().reference() //Root reference to Firebase database
    let childRef = Database.database().reference(withPath: "grocery-items") //Child reference in database
    let itemsRef = rootRef.child("grocery-items")
    let milkRef = itemsRef.child("milk")
    
    //User state handling if once user logged in navigate to logged in session
    let listener = Auth.auth().addStateDidChangeListener { (auth, user) in
      if user != nil {
        self.performSegue(withIdentifier: self.loginToList, sender: nil)
      }
    }

//    //When user logs out of the system
    Auth.auth().removeStateDidChangeListener(listener)
    
    
    print(rootRef.key)
    print(childRef.key)
    print(itemsRef.key)
    print(milkRef.key)
    
    
    //Just testing Json Codable Protocol
    let studentContact1 = StudentContact(phone: "7022736120", network: "Airtel")
    let studentContact2 = StudentContact(phone: "9900211234", network: "Vodafone")
    let student = Student(name: "Naresh", standard: "6th Standard", studentContacts:[studentContact1,studentContact2])
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    let jsonData = try! jsonEncoder.encode(student)
    print(FileManager.documentDirectoryURL)
    try! jsonData.write(to: URL(fileURLWithPath: "StudentData", relativeTo: FileManager.documentDirectoryURL.appendingPathComponent("student").appendingPathExtension("json")))
    let jsonDecoder = JSONDecoder()
    let jsonDecodableData = try! Data(contentsOf: URL(fileURLWithPath: "StudentData", relativeTo: FileManager.documentDirectoryURL.appendingPathComponent("student").appendingPathExtension("json")))
    let jsonDecodedStudentData = try! jsonDecoder.decode(Student.self, from: jsonDecodableData)
    print(jsonDecodedStudentData.name)
  }
  
  // MARK: Actions
  @IBAction func loginDidTouch(_ sender: AnyObject) {
    Auth.auth().signIn(withEmail: textFieldLoginEmail.text!, password: textFieldLoginPassword.text!)
    performSegue(withIdentifier: loginToList, sender: nil)
  }
  
  @IBAction func signUpDidTouch(_ sender: AnyObject) {
    let alert = UIAlertController(title: "Register",
                                  message: "Register",
                                  preferredStyle: .alert)
    
    let saveAction = UIAlertAction(title: "Save", style: .default) { action in
      let email = alert.textFields![0]
      let password = alert.textFields![1]
      Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: {
        (user, error) in
        if error != nil {
          if let errorCode = AuthErrorCode(rawValue: error!._code) {
            switch errorCode {
              case .weakPassword: print("Weak Password")
              case .accountExistsWithDifferentCredential : print("Account Already Exists")
            case .emailAlreadyInUse : print("Email Already Exists")
              default : print("Error")
            }
          }
        }
        if user != nil {
          user?.sendEmailVerification(completion: { error in
            print(error?.localizedDescription)
          })
          Auth.auth().signIn(withEmail: email.text!, password: password.text!)
          self.performSegue(withIdentifier: self.loginToList, sender: nil)
        }
      })
    }
    
    let cancelAction = UIAlertAction(title: "Cancel",
                                     style: .default)
    
    alert.addTextField { textEmail in
      textEmail.placeholder = "Enter your email"
    }
    
    alert.addTextField { textPassword in
      textPassword.isSecureTextEntry = true
      textPassword.placeholder = "Enter your password"
    }
    
    alert.addAction(saveAction)
    alert.addAction(cancelAction)
    present(alert, animated: true, completion: nil)
  }
}

extension LoginViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if textField == textFieldLoginEmail {
      textFieldLoginPassword.becomeFirstResponder()
    }
    if textField == textFieldLoginPassword {
      textField.resignFirstResponder()
    }
    return true
  }
  
}
