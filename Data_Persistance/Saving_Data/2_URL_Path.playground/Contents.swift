import Foundation

FileManager.documentDirectoryURL.path

//String component of url is known as path
let mysteryDataURL = URL(fileURLWithPath: "mystery", relativeTo: FileManager.documentDirectoryURL)
mysteryDataURL.path
let stringURL = FileManager.documentDirectoryURL.appendingPathComponent("string").appendingPathExtension("txt")
stringURL.path

