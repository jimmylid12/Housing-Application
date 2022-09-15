//
//  PostView.swift
//  Housing Application
//
//


//this is what the feedview uses to poupulate all the properties

import SwiftUI

struct PostView: View
{
    @State var post : PostModel

    
    
    @State var addHeartAnimation : Bool
    var showHeadFoot : Bool = true
    
    enum PostActionSheetOption
    {
        case general
        case reporting
    }
    
    @State var postImage: UIImage = UIImage(named: "Logo")!
    @State var profileImage : UIImage  = UIImage(named: "Logo")!
    
    @State var showActionSheet: Bool = false
    @State var actionSheetType: PostActionSheetOption = .general
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID : String?
    
    
    
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Request Changes")
                .foregroundColor(.blue)
        }
    }
    
    
    
    
    
    
    var body: some View
    
    
    
    {
        GroupBox {
            
        } label: {
        VStack(alignment: .center, spacing: 0, content:
        {
 
            ZStack
            {
                NavigationLink(destination: PropertyDetailsPage(post:post))
//                NavigationLink(destination: newPage( post: post))
                {
                    Image(uiImage: postImage)
                        .resizable()
                        .frame(width: 400, height: 350, alignment: .center)
                    .scaledToFit()
                }

            }
            

            if showHeadFoot
            {
                VStack(){
               
                    
                    Text(post.Price ?? " ")
                        .padding(10)
                        .background(Color("lightpurple"))
                     
                           .foregroundColor(.white)
                          
//                           .frame(maxWidth: .infinity)
                           .font(.system(size: 50, weight: .regular))
                         
                         
                    Spacer()
                    Text(post.streetName ?? " ")
                        .font(.caption)
                    
                    Text(post.City ?? " ")
                        .font(.caption)

                    Spacer()

                    
   
                }
                    .padding(.all , 20)

            }
             

        })
            .onAppear
            {
                getImages()
            }
            
           
        }
      
    }
    
    
    
    func getImages()
    {
        ImageManager.instance.downloadProfileImage(userID: post.userId) { returnedImage in
            if let image = returnedImage
            {
                self.profileImage = image
            }
            
            ImageManager.instance.downloadPostImage(postID: post.postId) { returnedImage in
                if let image = returnedImage
                {
                    self.postImage = image
                }
            }
        }
    }

        }
        
        
    



struct PostView_Previews: PreviewProvider
{
    static var post : PostModel = PostModel(postId: "", userId: "", username: "Joe Green", caption: "This is test cption", HouseFlat: "Thi", dateCreate: Date())
    static var previews: some View
    {
        PostView(post: post , addHeartAnimation : true, showHeadFoot: true)
    }
}
