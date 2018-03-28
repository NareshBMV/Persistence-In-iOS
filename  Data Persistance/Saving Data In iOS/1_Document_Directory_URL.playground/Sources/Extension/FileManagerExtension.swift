import Foundation

extension FileManager {
    public static var documentDirectoryURL:URL {
        //Userdomain mask says directory belongs to user 'first' is always common user directory representation
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first! //First is optional type
    }
}
