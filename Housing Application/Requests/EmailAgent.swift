//
//  EmailAgent.swift
//  Housing Application
//
//  Created by James Liddle on 16/08/2022.
//

//how the user creates a request for the customer

import SwiftUI

enum Mod {
    case new
    case edit
}

enum Act {
    case delete
    case done
    case cancel
}


struct EmailAgent: View {
    var post: PostModel
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    @State var showAlert : Bool = false
    @State var postUpdatedSuccessfully : Bool = false
    var cancelButton: some View {
        Button(action: { self.handleCancelTapped() }) {
            Text("Cancel")
                .foregroundColor(.white)
        }
    }
    
    
    @ObservedObject var viewModel = AgentModelView()
    @State var postImage: UIImage = UIImage(named: "Logo")!
    
    var mode: Mod = .new
    var completionHandler: ((Result<Act, Error>) -> Void)?
    
    var saveButton: some View {
        Button(action: { self.handleDoneTapped() }) {
            Text(mode == .new ? "Submit requests" : "Save")
            
            
            
        }
        .disabled(!viewModel.modified)
    }
    var body: some View
    {
        
        Image(uiImage: postImage)
            .resizable()
            .frame(width: 300, height: 250, alignment: .center)
            .scaledToFit()
        Spacer()
        Group {
            Spacer()
            TextField("Name", text: $viewModel.agent.name)
                .padding(20)
                .background(.thinMaterial)
                .cornerRadius(10)
            Spacer()
            TextField("email address", text: $viewModel.agent.email)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
            Spacer()
            TextField("phone number", text: $viewModel.agent.telephone)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
            Spacer()
            TextField("Message", text: $viewModel.agent.message)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
            Spacer()
            
        }
        
        
        VStack{
            
            Text("Choose your Flooring")
                .foregroundColor(.black)
                .bold()
                .shadow(color: .gray, radius: 1, x: 1.6, y: 1.6)
                .offset(x: 0, y: 60)
            
            Picker(selection: $viewModel.agent.flooringType, label: Text("flooring Type")
                .foregroundColor(Color.blue)
            ){
                Text("Carpet").tag("Carpet")
                Text("Laminate").tag("laminate")
                Text("tiles").tag("tiles")
                
            }.labelsHidden()
            
            
        }
        
        Spacer()
        
        
            .onAppear
        {
            getImages()
        }
        .navigationBarItems(
            leading: cancelButton,
            trailing: saveButton
        )
        
        
        
        
    }
    
    
    
    
    func handleCancelTapped() {
        self.dismiss()
    }
    
    func handleDoneTapped() {
        self.viewModel.handleDoneTapped()
        self.dismiss()
    }
    
    func handleDeleteTapped() {
        viewModel.handleDeleteTapped()
        self.dismiss()
        self.completionHandler?(.success(.delete))
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
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


