//
//  DataService.swift
//  Housing Application
//

//

// Used to handle upload and download of data other than the user from database
import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

class DataService
{
    //MARK: PROPERTIES
    
   
    @Published var modified = false
    static var instance = DataService()
    private var REF_POSTS = DB_BASE.collection("posts")
    @AppStorage(CurrentUserDefaults.userID) var currentUserID : String?
    
    //MARK: FUNCTIONS
    func uploadPost(image : UIImage , caption :  String? ,streetName :  String? , HouseFlat :  String? , postCode : String? ,City: String?, Description: String?,Price: String?,displayName : String , userID : String , handler : @escaping(_ success : Bool) -> ())
    {
        //Create new document
        var document = REF_POSTS.document()
        var postID = document.documentID
        
        //Upload Image to Storage
        ImageManager.instance.uploadPostImage(postID: postID, image: image) { success in
            if success
            {
                //Successfully uploaded data to Storage
                let postData : [String : Any] = [
                    DatabasePostsField.postID : postID ,
                    DatabasePostsField.userID : userID ,
                    DatabasePostsField.displayName : displayName ,
                    DatabasePostsField.caption : caption ?? "",
                    DatabasePostsField.streetName : streetName ?? "",
                    DatabasePostsField.HouseFlat : HouseFlat ?? "",
                    DatabasePostsField.postCode : postCode ?? "",
                    DatabasePostsField.City : City ?? "",
                    DatabasePostsField.Price : Price ?? "",
                    DatabasePostsField.Description : Description ?? "",
                    DatabasePostsField.dateCreated : FieldValue.serverTimestamp() 
                ]
                
                document.setData(postData) { error in
                    if error != nil
                    {
                        print("Error Uploading data to Post documents")
                        handler(false)
                        return
                    }
                    else
                    {
                        handler(true)
                        return
                    }
                }
            }
            else
            {
                print("Error uploading posts to database")
                handler(false)
                return
            }
        }
    }
    

    func downloadPostForFeed(handler : @escaping(_ posts : [PostModel]) -> ())
    {
        REF_POSTS.order(by: DatabasePostsField.dateCreated , descending : true ).limit(to : 10).getDocuments { querySnapshot , error in
            handler(self.getPostsFromSnapshot(querySnapshot: querySnapshot))
        }
    }

    
    private func getPostsFromSnapshot(querySnapshot : QuerySnapshot?) -> [PostModel]
    {
        var posts = [PostModel]()

        if let snapshot = querySnapshot , snapshot.documents.count > 0
        {
            for document in snapshot.documents
            {
                let postID = document.documentID
                if
                    let userID = document.get(DatabasePostsField.userID) as? String ,
                    let displayName = document.get(DatabasePostsField.displayName) as? String ,
                    let timestamp = document.get(DatabasePostsField.dateCreated) as? Timestamp
                    {

                    let caption = document.get(DatabasePostsField.caption) as? String
                    let streetName = document.get(DatabasePostsField.streetName) as? String
                    let HouseFlat = document.get(DatabasePostsField.HouseFlat) as? String
                    let postCode = document.get(DatabasePostsField.postCode) as? String
                    let City = document.get(DatabasePostsField.City) as? String
                    let Price = document.get(DatabasePostsField.Price) as? String
                    let Description = document.get(DatabasePostsField.Description) as? String
                        let time = timestamp.dateValue()


                    let newPost = PostModel(postId: postID, userId: userID, username: displayName, caption: caption, streetName: streetName, HouseFlat: HouseFlat,postCode: postCode, City: City,Price: Price,Description: Description, dateCreate: time)
                        posts.append(newPost)
                    }
            }
            return posts
        }
        else
        {
            print("No Documents for this particular User")
            return posts
        }
    }
    


    private func updateDisplayName(postID : String , displayName : String)
    {
        let data : [String : Any]  = [ DatabasePostsField.displayName : displayName]
        REF_POSTS.document(postID).updateData(data)
    }
}

