//
//  houseListView.swift
//  Housing Application
//
//  Created by James Liddle on 19/06/2022.
//

//Allows you to edit and delete the properties


import SwiftUI

enum Mode {
    case new
    case edit
}

enum Action {
    case delete
    case done
    case cancel
}


struct houseListView: View {
    @State private var showButton = false
    
    
    
    @Environment(\.presentationMode) private var presentationMode
    @State var presentActionSheet = false
    
    
    
    @ObservedObject var viewModel = HouseViewModel()
    var mode: Mode = .new
    var completionHandler: ((Result<Action, Error>) -> Void)?
    
    
    
    
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
                        
                      
                        TextField("houseNumber", text: $viewModel.house.houseNumber)
                        TextField("flat/house", text: $viewModel.house.flatNumber)
                        TextField("streetname", text: $viewModel.house.streetName)
                        TextField("city", text: $viewModel.house.city)
                        TextField("postcode", text: $viewModel.house.postCode)
                        TextField("edit", text: $viewModel.house.editInfo)
                        TextField("price", text: $viewModel.house.price)
                        
                        VStack{
                                         Text("Select Your Property type")
                                             
                                             .foregroundColor(.orange)
                                             .bold()
                                             .shadow(color: .gray, radius: 1, x: 1.6, y: 1.6)
                                             .offset(x: 0, y: 60)
                            Picker(selection: $viewModel.house.UserGender, label: Text("Property Type")
                                             .foregroundColor(Color.blue)
                                         ){
                                             Text("House").tag("House")
                                             Text("Flat").tag("Flat")
                                             
                                         }.labelsHidden()
                                     }
                     
                                       
                                       
                        
                        
                        
                    }
                    
                    
                    
                    
                    
                    
                    if mode == .edit {
                        Section {
                            Button("Delete property") { self.presentActionSheet.toggle() }
                                .foregroundColor(.red)
                        }
                    }
                }
                
            
                .navigationBarItems(
                    leading: cancelButton,
                    trailing: saveButton
                )
                
                .actionSheet(isPresented: $presentActionSheet) {
                    ActionSheet(title: Text("Are you sure?"),
                                buttons: [
                                    .destructive(Text("Delete property"),
                                                 action: { self.handleDeleteTapped() }),
                                    .cancel()
                                    
                                    
                                    
                                ])
                    
                    
                }
                
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
    
    
    

struct houseListView_Previews: PreviewProvider {
    static var previews: some View {
        let house = House( title: "Order",houseNumber: "houseNumber",flatNumber: "flatNumber",streetName: "streetName",city: "city",postCode: "postcode",editInfo: "editInfo",price: "price", UserGender: "")
        let houseViewModel = HouseViewModel(house: house)
        return houseListView(viewModel: houseViewModel, mode: .edit)
    }
}
