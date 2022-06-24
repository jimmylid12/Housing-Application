//
//  requestingEdits.swift
//  Housing Application
//
//  Created by James Liddle on 21/06/2022.
//
//This is where the customer can request certain features for the property like
//flooring etc

import SwiftUI

enum mode {
    case new
    case edit
}

enum action {
    case delete
    case done
    case cancel
}




struct requestingEdits: View {
    @State private var showButton = false
    
    
    
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    
    
    @ObservedObject var viewModel = HouseViewModel()
    var mode: mode = .new
    var completionHandler: ((Result<action, Error>) -> Void)?
    
    
    
    
    var cancelButton: some View {
        Button(action: { self.handleCancelTapped() }) {
            Text("Cancel")
                .foregroundColor(.white)
        }
    }
    
    var saveButton: some View {
        Button(action: { self.handleDoneTapped() }) {
            Text(mode == .new ? "Create Property" : "Save")
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
    
    

struct requestingEdits_Previews: PreviewProvider {
    static var previews: some View {
        let house = House( title: "Order",houseNumber: "houseNumber",flatNumber: "flatNumber",streetName: "streetName",city: "city",postCode: "postcode",editInfo: "editInfo")
        let houseViewModel = HouseViewModel(house: house)
        return requestingEdits(viewModel: houseViewModel, mode: .edit)
    }
}
