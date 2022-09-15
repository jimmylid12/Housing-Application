//
//  allowingEdits.swift
//  Housing Application
//
//  Created by James Liddle on 10/08/2022.
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



struct allowingEdits: View {
    @State private var showButton = false
    
    
    
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    
    
    @ObservedObject var viewModel = HouseViewModel()
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
            Text(modes == .new ? "Create Property" : "Save")
        }
        .disabled(!viewModel.modified)
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
                    Section(header: Text("Properties")) {
                        
                        TextField("Request Changes", text: $viewModel.house.editInfo)
              
                       
                        
                        
                    }
                    
                  
                }
                
            
                .navigationBarItems(
                    leading: cancelButton,
                    trailing: saveButton
                )
                
             
                
            }.edgesIgnoringSafeArea(.top)
            
            
            .navigationViewStyle(StackNavigationViewStyle())
            
        }
        
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
}
    
    

//struct requestingEdits_Previews: PreviewProvider {
//    static var previews: some View {
//        let post =PostModel( title: "Order",houseNumber: "houseNumber",flatNumber: "flatNumber",streetName: "streetName",city: "city",postCode: "postcode",editInfo: "editInfo",price: "", UserGender: "")
//        let PostViewModel = HouseViewModel(house: house)
//        return requestingEdits(viewModel: houseViewModel, mode: .edit)
//    }
//}
