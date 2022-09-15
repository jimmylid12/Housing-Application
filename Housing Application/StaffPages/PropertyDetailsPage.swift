//
//  newPage.swift
//  Housing Application
//
//  Created by James Liddle on 02/08/2022.
//

import SwiftUI

struct PropertyDetailsPage: View {
    
    //    @State var post : PostModel
    
    var showHeadFoot : Bool = true
    
    enum PostActionSheetOption
    {
        case general
        case reporting
    }
    
    @State var postImage: UIImage = UIImage(named: "Logo")!
    
    
    @State var showActionSheet: Bool = false
    @State var actionSheetType: PostActionSheetOption = .general
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID : String?
    
    
    @State private var showButton = false
    @State var presentEditOrderSheet = false
    var post: PostModel
    
    
    var body: some View {
        
        Text("Property Details")
        
        
        
        VStack(alignment: .center, spacing: 0, content:
                {
            
            
            Image(uiImage: postImage)
                .resizable()
                .frame(width: 400, height: 350, alignment: .center)
                .scaledToFit()
            
            VStack{
                HStack{
                    VStack{
                        Text(post.Price ?? " ")
                        
                            .font(.system(size: 50, weight: .regular))
                        
                        
                        Text(" Date added ")
                        Text(post.dateString)
                            .padding()
                    }
                    
                    HStack{
                        Button(action: {
                            
                        }, label: {
                            NavigationLink(destination: EmailAgent(post: post)) {
                                Text("Request Changes")
                                
                                    .padding(30)
                                    .padding(.bottom, 10)
                                    .frame(width: 200, height: 50 )                        .foregroundColor(.white)
                                    .background(Color("lightpurple"))
                                
                            }
                        })}
                    
                }
                
                Divider()
                HStack{
                    
                    Image(systemName: "info")
                        .symbolRenderingMode(.monochrome)
                        .foregroundColor(Color.accentColor)
                        .font(.system(size: 16, weight: .regular))
                    
                        .padding(.bottom, 50)
                    
                        .padding()
                    
                    Text("Address")
                        .font(.headline)
                        .font(.system(size: 16, weight: .regular))
                    
                    
                    Text(post.streetName ?? " ")
                        .font(.caption)
                    
                    Spacer()
                    Image(systemName: "house.circle")
                        .symbolRenderingMode(.monochrome)
                        .foregroundColor(Color.accentColor)
                        .font(.system(size: 16, weight: .regular))
                    
                        .padding(.bottom, 50)
                    
                    
                    Text("House/Flat")
                        .font(.headline)
                        .font(.system(size: 16, weight: .regular))
                    
                    Text(post.HouseFlat ?? " ")
                        .font(.caption)
                    
                    
                        .padding()
                }
                
                HStack{
              
                    Image(systemName: "location")
                        .symbolRenderingMode(.monochrome)
                        .foregroundColor(Color.accentColor)
                        .font(.system(size: 16, weight: .regular))
                    
                        .padding(.bottom, 50)
                        .padding()
                    
                    
                    
                    Text("City")
                        .font(.headline)
                        .font(.system(size: 16, weight: .regular))
                    
                    Text(post.City ?? " ")
                        .font(.caption)
                    
                    Spacer()
                    
                    Image(systemName: "p.circle")
                        .symbolRenderingMode(.monochrome)
                        .foregroundColor(Color.accentColor)
                        .font(.system(size: 16, weight: .regular))
                    
                        .padding(.bottom, 50)
                    
                    
                    
                    
                    Text("Postcode")
                        .font(.headline)
                        .font(.system(size: 16, weight: .regular))
                    
                    Text(post.postCode ?? " ")
                        .font(.caption)
                    .padding()            }
                Divider()
                
                
                Text("Property Description")
                    .font(.headline)
                    .font(.system(size: 16, weight: .regular))
                  
                Text(post.Description ?? " ")
                
                Divider()
                
                
                Spacer()
                
                
            }
            //            .padding(.all , 20)
           
            
        })
        .onAppear
        {
            getImages()
        }
      
    }
    
    
    func getImages()
    
    {
        ImageManager.instance.downloadPostImage(postID: post.postId) { returnedImage in
            if let image = returnedImage
            {
                self.postImage = image
            }
        }
    }
        
}

struct newPage_Previews: PreviewProvider

{
    static var post : PostModel = PostModel(postId: "", userId: "", username: "Joe Green", caption: "This is test cption", HouseFlat: "Thi", dateCreate: Date())
    static var previews: some View
    {
        PropertyDetailsPage(showHeadFoot: true, post: post)
    }
}

