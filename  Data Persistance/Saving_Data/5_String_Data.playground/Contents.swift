import Foundation
//: ## Bytes
let mysteryBytes: [UInt8] = [
  240,          159,          152,          184,
  240,          159,          152,          185,
  0b1111_0000,  0b1001_1111,  0b1001_1000,  186,
  0xF0,         0x9F,         0x98,         187
]

let mysteryDataURL = URL(
  fileURLWithPath: "mystery",
  relativeTo: FileManager.documentDirectoryURL
)

mysteryDataURL.path

let mysteryData = Data(bytes: mysteryBytes)
try mysteryData.write(to: mysteryDataURL)

let savedMysteryData = try Data(contentsOf: mysteryDataURL)
let savedMysteryBytes = Array(savedMysteryData)
savedMysteryBytes == mysteryBytes
savedMysteryData == mysteryData

//Adding extension and write data to!
try mysteryData.write(to: mysteryDataURL.appendingPathExtension(".txt"))
//: ## String
let stringURL =
  FileManager.documentDirectoryURL
  .appendingPathComponent("string1")
  .appendingPathExtension("txt")

let string = String(bytes: savedMysteryData, encoding: .utf8)
let stringData = String(data: savedMysteryData, encoding: .utf8)

//String initializer for writing data
try stringData?.write(to: stringURL, atomically: true, encoding: .utf8)
//Reading with string method
try String(contentsOf: stringURL)
//: ## Challenge
let challengeString = "low F#"
let challengeStringURL = URL(
  fileURLWithPath: challengeString,
  relativeTo: FileManager.documentDirectoryURL
).appendingPathExtension("txt")
