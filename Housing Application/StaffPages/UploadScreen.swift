

import SwiftUI
import UIKit

//page for choosing either camera or photo gallery

struct UploadScreen: View
{
    @State var showImagePicker : Bool = false
    @State var imageSelected: UIImage = UIImage(named: "Logo")!
    @State var sourceType : UIImagePickerController.SourceType = .camera
    @State var showPostImageView: Bool = false
    
    var body: some View
    {
        ZStack
        {
            VStack
            {
                Button (action:{
                    sourceType = UIImagePickerController.SourceType.camera
                    showImagePicker.toggle()
                } , label: {
                    Text("Take Photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("Black"))
                })
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color("White"))
                
                Button (action:{
                    sourceType = UIImagePickerController.SourceType.photoLibrary
                    showImagePicker.toggle()
                } , label: {
                    Text("Import Photo".uppercased())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color("White"))
                })
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .background(Color("lightpurple"))
                
            }
            .edgesIgnoringSafeArea(.top)
            .sheet(isPresented: $showImagePicker, onDismiss: segueToPostImageView, content: {
                ImagePicker(imageSelected: $imageSelected, sourceType: $sourceType )
            })
            
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200, alignment: .center)
                .shadow(radius: 12)
                .fullScreenCover(isPresented: $showPostImageView , content : {
                    PostImageView(imageSelected: $imageSelected)
                })
        }
    }
  

    func segueToPostImageView()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
        {
            showPostImageView.toggle()
        }
    }
}

struct UploadScreen_Previews: PreviewProvider
{
    static var previews: some View
    {
        UploadScreen()
    }
}
