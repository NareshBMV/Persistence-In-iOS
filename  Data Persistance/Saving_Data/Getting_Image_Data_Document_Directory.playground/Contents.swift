import Foundation
import UIKit

try FileManager.copyPNGSubdirectoriesToDocumentDirectory(subdirectoryNames: "Scenes", "Stickers")

FileManager.documentDirectoryURL

FileManager.getPNGFromDocumentDirectory(subdirectoryName: "Stickers", imageName: "cat")
FileManager.getPNGFromDocumentDirectory(subdirectoryName: "Scenes", imageName: "Forest")
