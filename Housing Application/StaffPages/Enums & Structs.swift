
import Foundation
import SwiftUI


struct DatabaseUserFields
{
    static let display_name = "display_name"
    static let email = "email"
    static let provider = "provider"
    static let provider_id = "provider_id"
    static let user_id = "user_id"
    static let bio = "bio"
    static let date_created = "date_created"

}

struct CurrentUserDefaults
{
    static let displayName = "display_name"
    static let bio = "bio"
    static let userID = "user_id"
}

struct DatabasePostsField
{
    static let postID = "post_id"
    static let userID = "user_id"
    static let displayName = "display_name"
    static let caption = "caption"
    static let streetName = "streetName"
    static let HouseFlat = "HouseFlat"
    static let postCode = "postCode"
    static let City = "City"
    static let Price = "Price"
    static let Description = "description"
    static let dateCreated = "data_created"
   
 
}



// Custom Textfield
struct SuperCustomTextFieldStyle: TextFieldStyle
{
    func _body(configuration: TextField<_Label>) -> some View
    {
        configuration
            .padding()
    }
}
