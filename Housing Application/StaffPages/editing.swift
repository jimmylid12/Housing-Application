//
//  editing.swift
//  Housing Application
//
//  Created by James Liddle on 13/08/2022.
//

import SwiftUI


enum modes {
    case new
    case edit
}

enum actions {
    case delete
    case done
    case cancel
}


struct editing: View {
    
    
    @State var postCodeText : String = ""
    @State private var showButton = false
    
    
    
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    
    
    @ObservedObject var viewModels = newModel()
    var modes: modes = .new
    var completionHandler: ((Result<action, Error>) -> Void)?
    
    
    
    
    var cancelButton: some View {
        Button(action: { self.handleCancelTapped() }) {
            Text("Cancel")
                .foregroundColor(.white)
        }
    }
    
    var saveButton: some View {
        Button(action: { self.handleDoneTapped() }) {
            Text(modes == .new ? "Chhg" : "Save")
        }
        .disabled(!viewModels.modified)
    }
    var body: some View {
        
        NavigationView {
            VStack(){
                
                TitleView(Title: "") .onAppear(perform: {
                    
                    
                    
                })
                
                VStack(){
                    
                    
                    
                    Text("Properties").font(.largeTitle)
          
                }.padding([.leading, .top], 10).frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
                Form {
                    Section(header: Text("P")) {
                        
//                        TextField("jjhjhj ", text: $viewModels.post.streetName)
              
                       
                        
                        
                    }
                    
                  
                }
                
            
                .navigationBarItems(
                    leading: cancelButton,
                    trailing: saveButton
                )
                
                if modes == .edit {
                    Section {
                        Button("Delete property") { self.presentActionSheet.toggle() }
                            .foregroundColor(.red)
                    }
                }
                
                

            }.edgesIgnoringSafeArea(.top)
                .actionSheet(isPresented: $presentActionSheet) {
                    ActionSheet(title: Text("Are you sure?"),
                                buttons: [
                                    .destructive(Text("Delete property"),
                                                 action: { self.handleDeleteTapped() }),
                                    .cancel()
                                    
                                    
                                    
                                ])
                    
                    
                }

            
//            .navigationViewStyle(StackNavigationViewStyle())
            
        }
        
    }
    
    func handleCancelTapped() {
        self.dismiss()
    }
    
    func handleDoneTapped() {
        self.viewModels.handleDoneTapped()
        self.dismiss()
    }
    
    func handleDeleteTapped() {
        viewModels.handleDeleteTapped()
        self.dismiss()
        self.completionHandler?(.success(.delete))
    }
    
    func dismiss() {
        self.presentationMode.wrappedValue.dismiss()
    }
}
    

struct editing_Previews: PreviewProvider {
    static var previews: some View {
        let post = PostModel(postId: "", userId: "", username: "Joe Green", caption: "This is test cption", HouseFlat: "Thi", likeCount: 0, dateCreate: Date(), likedByUser: false)
        let newModel = newModel(post: post)
        return editing(viewModels: newModel, modes: .edit)
    }
}
