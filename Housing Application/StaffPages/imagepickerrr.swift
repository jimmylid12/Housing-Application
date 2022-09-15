//
//  imagepickerrr.swift
//  Housing Application
//
//  Created by James Liddle on 05/07/2022.
//

import SwiftUI
import FirebaseStorage
import Combine

struct imagepickerrr: UIViewControllerRepresentable {
    
    @Binding var shown: Bool
    @Binding var imageURLList:[String]
    @State var imageFileName:String = ""
    
    func makeCoordinator() -> imagepickerrr.Coordinator {
        return imagepickerrr.Coordinator(parent: self)
    }
    
    class Coordinator: NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
        var parent: imagepickerrr
        let storage = Storage.storage().reference()
        init(parent: imagepickerrr) {
            self.parent = parent
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.shown.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let image = info[.originalImage] as! UIImage
            parent.imageFileName = makeImageFileName()
            uploadImageToFireBase(image: image)
        }
        
        func uploadImageToFireBase(image: UIImage) {
            // Create the file metadata
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpeg"
            
            // Upload the file to the path FILE_NAME
            storage.child(parent.imageFileName).putData(image.jpegData(compressionQuality: 0.42)!, metadata: metadata) { (metadata, error) in
                guard let metadata = metadata else {
                  // Uh-oh, an error occurred!
                  print((error?.localizedDescription)!)
                  return
                }
                // Metadata contains file metadata such as size, content-type.
                let size = metadata.size
                
                
                self.loadImageFromFirebase(imagePath: self.parent.imageFileName)
                print("Upload size is \(size)")
                print("Upload success")
                self.parent.shown.toggle()
            }
        }
        
        func loadImageFromFirebase(imagePath: String) {
            let storage = Storage.storage().reference(withPath: imagePath)
            storage.downloadURL { (url, error) in
                if error != nil {
                    print((error?.localizedDescription)!)
                    return
                }
                print("Download success")
                let urlString = "\(url!)"
                self.parent.imageURLList.append(urlString)
            }
        }
        
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<imagepickerrr>) -> UIImagePickerController {
        let imagepic = UIImagePickerController()
        imagepic.sourceType = .photoLibrary
        imagepic.delegate = context.coordinator
        return imagepic
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<imagepickerrr>) {
    }
}
