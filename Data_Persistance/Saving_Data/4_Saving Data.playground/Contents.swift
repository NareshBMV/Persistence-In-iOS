import Foundation
//: ## Bytes
//UInt8 - means 8 bit unsigned integer
let mysteryBytes: [UInt8] = [
  240,          159,          152,          184,
  240,          159,          152,          185,
  0b1111_0000,  0b1001_1111,  0b1001_1000,  186,
  0xF0,         0x9F,         0x98,         187
]

//Saving data to Created URL
let mysteryDataURL = URL(
    
  fileURLWithPath: "mystery",
  relativeTo: FileManager.documentDirectoryURL
)

mysteryDataURL.path

let data = Data(bytes: mysteryBytes)
try data.write(to: mysteryDataURL)
let dataContents = try Data(contentsOf: mysteryDataURL)
let arrayContents = Array(dataContents)
//Equating two data
arrayContents == mysteryBytes
dataContents == data
//: ## String
let stringURL =
  FileManager.documentDirectoryURL
  .appendingPathComponent("string")
  .appendingPathExtension("txt")
//: ## Challenge
let challengeString = "low F#"
let challengeStringURL = URL(
  fileURLWithPath: challengeString,
  relativeTo: FileManager.documentDirectoryURL
).appendingPathExtension("txt")





