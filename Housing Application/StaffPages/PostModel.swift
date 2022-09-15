

import Foundation
import SwiftUI


//the information which is uploaded to firebase

struct PostModel : Hashable , Identifiable , Codable
{
    
   var id: String?
 //   var id = UUID()
    var postId : String
    var userId : String
    var username : String
    var caption : String?
    var streetName : String?
    var HouseFlat : String?
    var postCode : String?
    var City : String?
    var Price : String?
    var Description : String?

    var dateCreate : Date
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd 'of' MMMM"
        return formatter.string(from: dateCreate)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
