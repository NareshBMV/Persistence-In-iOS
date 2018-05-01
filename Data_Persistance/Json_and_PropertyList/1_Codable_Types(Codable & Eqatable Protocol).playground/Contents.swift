//Introduction
//Codable Types, Json, Property List
//Swift4 Apple stadandardized the process
//Codable protocol which combines encodable and decodable protocol
//Codable- A type that can convert itself into and out of external representation - The process is know as making types codable
import UIKit

try FileManager.copyPNGSubdirectoriesToDocumentDirectory(subdirectoryNames: "Scenes", "Stickers")

let name = "Kiru"
let birthday = DateComponents(calendar: .current, year: 1992, month: 9, day: 15).date!
let normalizedPosition = CGPoint(x: 0.3, y: 0.5)
let imageName = "cat"

let sticker = Sticker(name: name, birthday: birthday, normalizedPosition: normalizedPosition, imageName: imageName)
sticker == sticker
sticker.image



