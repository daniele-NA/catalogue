import Foundation


// USED FOR FIRESTORE
struct UserDto : Codable {
    let id:String
    let name:String
    let email:String
    let joined : TimeInterval
}

