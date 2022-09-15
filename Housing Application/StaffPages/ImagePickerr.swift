//
//  ImagePickerr.swift
//  Housing Application
//
//  Created by James Liddle on 05/07/2022.
//

import UIKit
import SwiftUI
//import SDWebImageSwiftUI
import Firebase

struct ImagePickerr: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePickerr = UIImagePickerController()
        imagePickerr.allowsEditing = false
        imagePickerr.sourceType = sourceType
        imagePickerr.delegate = context.coordinator
        
        return imagePickerr
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
                uploadprofileImage(image: image)
            }

            parent.presentationMode.wrappedValue.dismiss()
            
        }
    }
}

