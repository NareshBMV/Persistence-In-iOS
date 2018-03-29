import Foundation
import UIKit

//Sticker itself is considered as codable by compiler
public struct Sticker:Codable {
    
   public init(
     name:String,
     birthday:Date,
     normalizedPosition:CGPoint,
     imageName:String) {
        self.name = name
        self.birthday = birthday
        self.normalizedPosition = normalizedPosition
        self.imageName = imageName
    }
    
    public let name:String
    public let birthday:Date?
    public let normalizedPosition:CGPoint
    public let imageName:String
    public var image:UIImage? {
        return FileManager.getPNGFromDocumentDirectory(subdirectoryName: "Scenes", imageName: "Forest")
    }

}

//To compare encodable and decodable obj are same, sticker is conforming to Equatable protocol
extension Sticker:Equatable {
    public static func ==(sticker0: Self, sticker1: Self) -> Bool
    {
        return sticker0.name == sticker1.name &&
            sticker0.birthday == sticker1.birthday &&
            sticker0.imageName == sticker1.imageName &&
            sticker0.normalizedPosition == sticker1.normalizedPosition
    }
}

//Mostly Used For JSON
//JSON - Javascript Object Notation
//Dictionary is Heterogeneous for Json storage with different types
//Data (type) is not supported in JSON so we gonna store it in string format
//Date too






