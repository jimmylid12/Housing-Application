//
//  SettingsView.swift
//  Housing Application
//
//  Created by James Liddle on 05/07/2022.
//

import SwiftUI
import FirebaseFirestore
import Firebase
import SDWebImageSwiftUI

struct SettingsView: View {
    @ObservedObject var settingsViewModel = SettingsViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var presented = false
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State private var imageURL = URL(string: "")

var body: some View {
    NavigationView {
      VStack {
        
        WebImage(url: imageURL)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 250.0, height: 250.0, alignment: .center)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 4))
            .shadow(radius: 10)
            .scaledToFit()


        Text("Project")
          .font(.title)
          .fontWeight(.semibold)
        
        Form {
          Section {
            HStack {
              Image(systemName: "checkmark.circle")
              Text("Upload profile image")
              Spacer()
              Text("Plain")
                .onTapGesture {
                    self.isShowPhotoLibrary = true
                }
                .sheet(isPresented: $isShowPhotoLibrary) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                }
                
            }
          }
          
      
          
          AccountSection(settingsViewModel: self.settingsViewModel)
        }
        
        .navigationBarTitle("Settings", displayMode: .inline)
        .navigationBarItems(trailing:
          Button(action: { self.presentationMode.wrappedValue.dismiss() }) {
            Text("Done")
        })
        
      }
      .onAppear(perform: loadImageFromFirebase)
        
    }
 
  }
    func loadImageFromFirebase() {
        let storage = Storage.storage()
        guard let userid = Auth.auth().currentUser?.uid else { return }
        let storageRef = storage.reference().child(userid+"/profilephoto"+"/profile.jpeg")
        storageRef.downloadURL {
            (url, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            self.imageURL = url!
        }
    }
    
}
