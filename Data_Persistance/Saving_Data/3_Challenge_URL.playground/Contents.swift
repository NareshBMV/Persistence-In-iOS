import Foundation

let mysteryDataURL = URL(
  fileURLWithPath: "mystery",
  relativeTo: FileManager.documentDirectoryURL
)
//: ## String
let stringURL =
  FileManager.documentDirectoryURL
  .appendingPathComponent("string")
  .appendingPathExtension("txt")
//: ## Challenge
let challengeString: String = "sample"
let challengeStringURL: URL = FileManager.documentDirectoryURL
                                .appendingPathComponent("Sample")
                                .appendingPathExtension("txt")
let URLPractice:URL = URL(
                            fileURLWithPath: challengeString,
                            relativeTo: FileManager.documentDirectoryURL
                            )
challengeStringURL.lastPathComponent
