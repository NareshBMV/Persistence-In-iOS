import UIKit

try FileManager.copyPNGSubdirectoriesToDocumentDirectory(subdirectoryNames: "Scenes", "Stickers")

let sticker = Sticker(
  name: "David Meowie",
  birthday: DateComponents(
    calendar: .current,
    year: 1947, month: 1, day: 8
  ).date!,
  normalizedPosition: CGPoint(x: 0.3, y: 0.5),
  imageName: "cat"
)

sticker.image
sticker.name

FileManager.documentDirectoryURL.path

do {
    //Encoding to Json and writing to file
    let jsonURL = URL(fileURLWithPath: "Stickers", relativeTo: FileManager.documentDirectoryURL).appendingPathComponent("Stickert").appendingPathExtension("json")
    let jsonEncoder = JSONEncoder()
    jsonEncoder.outputFormatting = .prettyPrinted
    let jsonData = try jsonEncoder.encode(sticker)
    
    try jsonData.write(to: jsonURL)
    
    //Reading from file and decoding
    let jsonDecoder = JSONDecoder()
    let jsonDecodableData = try Data(contentsOf: jsonURL)
    let jsonDecodedSticker = try jsonDecoder.decode(Sticker.self, from: jsonDecodableData)
    jsonDecodedSticker == sticker
    jsonDecodedSticker.name
    jsonDecodedSticker.birthday
    jsonDecodedSticker.imageName
}
catch {
    print(error)
}


//Mostly Used For JSON
//JSON - Javascript Object Notation
//Dictionary is Heterogeneous for Json storage with different types
//Data (type) is not supported in JSON so we gonna store it in string format
//Date too

//Date Encoding Strategy
//1.differredToData (taking sample date to specify the format)
//2.iso 8601
//CustomFormat(formatted, custom)
//EpochFormat(milliseconds since 1970, seconds since 1970)
