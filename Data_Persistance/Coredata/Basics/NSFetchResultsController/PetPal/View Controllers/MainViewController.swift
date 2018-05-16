/**
* Copyright (c) 2017 Razeware LLC
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
* Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
* distribute, sublicense, create a derivative work, and/or sell copies of the
* Software in any work that is designed, intended, or marketed for pedagogical or
* instructional purposes related to programming, coding, application development,
* or information technology.  Permission for such use, copying, modification,
* merger, publication, distribution, sublicensing, creation of derivative works,
* or sale is expressly withheld.
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
import CoreTelephony
import CoreData
class MainViewController: UIViewController {
	@IBOutlet private weak var collectionView:UICollectionView!
    private var fetchedRC : NSFetchedResultsController<Friend>!
	private var selected:IndexPath!
	private var picker = UIImagePickerController()
	private var images = [String:UIImage]()
    private var appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var query = ""
    var backgroundTask:UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
	override func viewDidLoad() {
		super.viewDidLoad()
		picker.delegate = self
	}

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        //Checking Simple Fetch and update existing record
//        var value:[Friend] = []
//        let name = "Amaya"
//        let fetchRequest = Friend.fetchRequest() as NSFetchRequest
//        fetchRequest.predicate = NSPredicate(format: "name contains[cd] %@", name)
//        let sort = NSSortDescriptor(key: #keyPath(Friend.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
//        let eyeColorSort = NSSortDescriptor(key: #keyPath(Friend.eyeColor), ascending: true)
//        fetchRequest.sortDescriptors = [eyeColorSort, sort]
//        do {
//            fetchedRC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//            try fetchedRC.performFetch()
//            value = fetchedRC.fetchedObjects!
//        }
//        catch let error as NSError {
//            print(error)
//        }
//        let friend = value.first
//        friend?.name = "Naresh"
//        appDelegate.saveContact()
        
        refresh()
        showEditButton()
    }
    
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK:- Navigation
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "petSegue" {
			if let index = sender as? IndexPath {
				let pvc = segue.destination as! PetsViewController
				let friend = fetchedRC.object(at: index)
                pvc.friend = friend
			}
		}
	}

	// MARK:- Actions
	@IBAction func addFriend() {
        let data = FriendData()
        let friend = Friend(entity: Friend.entity(), insertInto: context)
        friend.name = data.name
        friend.address = data.address
        friend.dob = data.dob as NSDate
        friend.eyeColor = data.eyeColor
        appDelegate.saveContact()
        refresh()
        collectionView.reloadData()
        
//        //Decoding For NSManagedObject Using Decodable
//        do {
//
//            let url = URL(fileURLWithPath: "Friend", relativeTo: FileManager.documentDirectoryURL.appendingPathComponent("student").appendingPathExtension("json"))
//
//            let jsonDecoder = JSONDecoder()
//            jsonDecoder.dateDecodingStrategy = .iso8601
//            jsonDecoder.dataDecodingStrategy = .base64
//            let jsondata = try Data(contentsOf: url)
//            let decodedObjectsArray = try jsonDecoder.decode([Friend].self, from:jsondata)
//            print(decodedObjectsArray.count)
//
//            for friend in decodedObjectsArray {
//                context.insert(friend)
//                try context.save()
//            }
//        } catch let error as NSError {
//            print("Error : \(error)")
//        }
//
//        refresh()
//        collectionView.reloadData()

    }
	
	// MARK:- Private Methods
	private func showEditButton() {
        guard let objects = fetchedRC.fetchedObjects else {
            return
        }
		if objects.count > 0 {
			navigationItem.leftBarButtonItem = editButtonItem
		}
	}
    
    func refresh() {
        do{
            let request = Friend.fetchRequest() as NSFetchRequest
            if !query.isEmpty{
                request.predicate = NSPredicate(format: "name contains[cd] %@", query)
            }
            let sort = NSSortDescriptor(key: #keyPath(Friend.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
            let eyeColorSort = NSSortDescriptor(key: #keyPath(Friend.eyeColor), ascending: true)
            request.sortDescriptors = [eyeColorSort, sort]
            
            fetchedRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: #keyPath(Friend.eyeColor), cacheName: nil)
            try fetchedRC.performFetch()
            
//            //Encoding For NSManagedObject Using Encodable
//            let url = URL(fileURLWithPath: "Friend", relativeTo: FileManager.documentDirectoryURL.appendingPathComponent("student").appendingPathExtension("json"))
//            let jsonEncoder = JSONEncoder()
//            jsonEncoder.outputFormatting = .prettyPrinted
//            jsonEncoder.dateEncodingStrategy = .iso8601
//            jsonEncoder.dataEncodingStrategy = .base64
//            let friendsList = fetchedRC.fetchedObjects
//            let jsonData = try! jsonEncoder.encode(friendsList)
//            print(FileManager.documentDirectoryURL)
//            try! jsonData.write(to:url)
//
//            print(FileManager.documentDirectoryURL)
//
//            //Decoding For NSManagedObject Using Decodable
//            let jsonDecoder = JSONDecoder()
//            jsonDecoder.dateDecodingStrategy = .iso8601
//            jsonDecoder.dataDecodingStrategy = .base64
//            let jsondata = try Data(contentsOf: url)
//            let decodedObjectsArray = try jsonDecoder.decode([Friend].self, from:jsondata)
//            print(decodedObjectsArray.count)
//
//            //Looping Over Fetched Data
//            for friend in decodedObjectsArray {
//                print("Name : \(friend.name!) ; Address : \(String(describing: friend.address!)) ; Age : \(friend.age)")
//            }
            
        } catch let error as NSError {
            print("Cannot Fetch \(error) and \(error.userInfo)")
        }
    }
}

// Collection View Delegates
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderRow", for: indexPath)
        
        if let label = view.viewWithTag(1000) as? UILabel {
            if let friends = fetchedRC.sections?[indexPath.section].objects as? [Friend], let friend = friends.first {
                label.text = "Eye Color : \(friend.eyeColorString)"
            }
        }
        return view
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return fetchedRC.sections?.count ?? 0
    }
    
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let sections = fetchedRC.sections, let objects = sections[section].objects else {
            return 0
        }
		return objects.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCell", for: indexPath) as! FriendCell
		let friend = fetchedRC.object(at: indexPath)
		cell.nameLabel.text = friend.name
        cell.addressLabel.text = friend.address
        cell.ageLabel.text = "Age : \(friend.age)"
        cell.eyeColorView.backgroundColor = friend.eyeColor as? UIColor
       
        if let image = friend.picture {
            cell.pictureImageView.image = UIImage(data: image as Data)
        }
        else {
            cell.pictureImageView.image = UIImage(named: "person-placeholder")
        }
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if isEditing {
			selected = indexPath
			self.navigationController?.present(picker, animated: true, completion: nil)
		} else {
			performSegue(withIdentifier: "petSegue", sender: indexPath)
		}
	}
}

// Search Bar Delegate
extension MainViewController:UISearchBarDelegate {
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		guard let text = searchBar.text else {
			return
		}
        
        //Normal Search Functionality
//        isFiltered = true
//        filtered = friends.filter({(friend) -> Bool in
//            return friend.name!.contains(query)
//        })
        
        query = text
        refresh()
		searchBar.resignFirstResponder()
		collectionView.reloadData()
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        query = ""
        refresh()
		searchBar.text = nil
		searchBar.resignFirstResponder()
		collectionView.reloadData()
	}
}

// Image Picker Delegates
extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
		let image = info[UIImagePickerControllerOriginalImage] as! UIImage
		let friend = fetchedRC.object(at: selected)
        friend.picture = UIImagePNGRepresentation(image) as NSData?
        appDelegate.saveContact()
		collectionView?.reloadItems(at: [selected])
		picker.dismiss(animated: true, completion: nil)
	}
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



