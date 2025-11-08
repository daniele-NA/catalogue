import Foundation

// USED FOR FIRESTORE
struct ItemDto : Identifiable,Codable {
    let id:String
    let createdBy:String
    let title:String
    let description:String
    let price:Float
    let createdAt : TimeInterval
}

