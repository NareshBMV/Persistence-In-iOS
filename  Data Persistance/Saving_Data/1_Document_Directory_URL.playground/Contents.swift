//Sandboxing restriction in iOS only handfull of directories are available in iOS for saving files
//User DocumentDirectory is commonly used
//Directories are represented by URL Struct
//FileManager is used to get document directory URL we need
//All FileManager methods are threadsafe

import Foundation

//One way to implement
FileManager.documentDirectoryURL

//Other way to implement
try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//Create is false bcoz creation is task of OS and not user









