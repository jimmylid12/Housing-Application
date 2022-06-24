//
//  requestEdits.swift
//  Housing Application
//
//  Created by James Liddle on 21/06/2022.
//

//What allows customers to edit the information, here customers can
//make a request to update something in particular. This gets added
//to the property, which then can be seen by staff who can confirm it
//or delete it.


import SwiftUI

struct requestEdits: View {
   
    @State private var showButton = false
    @State var presentEditOrderSheet = false
    var house: House
    
    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Request Changes")
                .foregroundColor(.black)
        }
    }

    var body: some View {
        
    VStack(){
        Text("Request Changes to be approved")
        
            .navigationBarItems(trailing: editButton {
                self.presentEditOrderSheet.toggle()
            })
        
        
      
        
            .onAppear() {
                print("houseDetailsView.onAppear() for \(self.house.title)")
            }
            .onDisappear() {
                print("houseDetailsView.onDisappear()")
            }
            .sheet(isPresented: self.$presentEditOrderSheet) {
              requestingEdits(viewModel: HouseViewModel(house: house), mode: .edit) { result in
                    if case .success(let action) = result, action == .delete {

                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)
        
        .navigationViewStyle(StackNavigationViewStyle())
    }

}

struct requestEdits_Previews: PreviewProvider {
    static var previews: some View {
        let house = House(id: "",title: "",houseNumber: "",flatNumber: "",streetName: "",city: "",postCode:"",editInfo: "")
        return
            NavigationView {
               requestEdits(house: house)
            }
    }
}
