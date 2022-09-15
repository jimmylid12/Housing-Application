
//This is how you upload information to the database, after selecting an image




import SwiftUI

enum Modes {
    case new
    case edit
}

enum Actions {
    case delete
    case done
    case cancel
}


struct PostImageView: View
{
    @Environment(\.presentationMode) var presentationMode
    @State var captionText : String = ""
    @State var streetNameText : String = ""
    @State var houseFlatText : String = ""
    @State var postCodeText : String = ""
    @State var postCityText : String = ""
    @State var postPriceText : String = ""
    @State var postDescriptionText : String = ""
    @State var postDateText : String = ""
    
    @Binding var imageSelected : UIImage
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID : String?
    @AppStorage(CurrentUserDefaults.displayName) var currentDisplayName : String?
    
    @State var showAlert : Bool = false
    @State var postUpdatedSuccessfully : Bool = false
    
    
    @ObservedObject var viewModels = PostModelArray()
    var mode: Modes = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
    
    
    var body: some View
    {
        VStack(alignment: .center, spacing: 0, content: {
            HStack
            {
                Button
                {
                    presentationMode.wrappedValue.dismiss()
                } label:
                {
                    Image(systemName: "xmark")
                        .font(.title2)
                    
                    
                        .padding()
                }
                Spacer()
            }
            
            ScrollView(.vertical, showsIndicators: false, content: {
                Image(uiImage: imageSelected)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200, alignment: .center)
                    .cornerRadius(12)
                    .clipped()
                
                
                TextField("House/ Flat ", text: $houseFlatText)
                    .background(Color("Beige"))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .frame( height: 60)
                    .frame( maxWidth : .infinity )
                    .font(.headline)
                    .textFieldStyle(SuperCustomTextFieldStyle())
                    .autocapitalization(.sentences)
                
                TextField("Address", text: $streetNameText)
                    .background(Color("Beige"))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .frame( height: 60)
                    .frame( maxWidth : .infinity )
                    .font(.headline)
                    .textFieldStyle(SuperCustomTextFieldStyle())
                    .autocapitalization(.sentences)
                
                TextField("City", text: $postCityText)
                    .background(Color("Beige"))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .frame( height: 60)
                    .frame( maxWidth : .infinity )
                    .font(.headline)
                    .textFieldStyle(SuperCustomTextFieldStyle())
                    .autocapitalization(.sentences)
                
                TextField("PostCode", text: $postCodeText)
                    .background(Color("Beige"))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .frame( height: 60)
                    .frame( maxWidth : .infinity )
                    .font(.headline)
                    .textFieldStyle(SuperCustomTextFieldStyle())
                    .autocapitalization(.sentences)
                
                
                TextField("Price", text: $postPriceText)
                    .background(Color("Beige"))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .frame( height: 60)
                    .frame( maxWidth : .infinity )
                    .font(.headline)
                    .textFieldStyle(SuperCustomTextFieldStyle())
                    .autocapitalization(.sentences)
                
                TextField("Description", text: $postDescriptionText)
                    .background(Color("Beige"))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .frame( height: 60)
                    .frame( maxWidth : .infinity )
                    .font(.headline)
                    .textFieldStyle(SuperCustomTextFieldStyle())
                    .autocapitalization(.sentences)
                
                
                
                Button
                {
                    postPicture()
                } label: {
                    Text("Post Picture!".uppercased())
                        .font(.title3)
                        .foregroundColor(Color.white)
                        .fontWeight(.bold)
                        .padding()
                        .frame(height:60)
                        .frame(maxWidth : .infinity)
                        .cornerRadius(12)
                        .background(Color("Purple"))
                        .padding(.horizontal)
                    
                }
                
                
            })
            .alert(isPresented: $showAlert) {
                getAlert()
            }
        })
        .accentColor(Color("Purple"))
        
    }
    
    
    func postPicture()
    {
        print("Post Property")
        
        
        
        DataService.instance.uploadPost(image: imageSelected, caption: captionText, streetName: streetNameText, HouseFlat: houseFlatText, postCode:postCodeText,  City:postCityText, Description:postDescriptionText, Price:postPriceText, displayName: currentDisplayName ?? " ", userID: currentUserID ?? " "  ) { success in
            self.postUpdatedSuccessfully = success
            self.showAlert.toggle()
            
        }
    }
    
    func getAlert() -> Alert
    {
        if postUpdatedSuccessfully
        {
            return Alert(title: Text("Post Updated Successfully"), message: nil, dismissButton: .default(Text("Ok") , action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
        else
        {
            return Alert(title: Text("Post Update Not Successful"), message: nil, dismissButton: .default(Text("Ok")))
        }
    }
}

struct PostImageView_Previews: PreviewProvider
{
    @State static var image : UIImage = UIImage(named: "dog1")!
    static var previews: some View
    {
        PostImageView(imageSelected: $image)
    }
}
