//
//  HouseDetailsView.swift
//  Housing Application
//
//  Created by James Liddle on 19/06/2022.
//
//After clicking on houseslistView it displays the information so you can
//edit it

import SwiftUI

struct HouseDetailsView: View {

    @State private var showButton = false
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditOrderSheet = false
    var house: House

    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Edit")
                .foregroundColor(.black)
        }
    }

    var body: some View {

    VStack(){

            TitleView(Title: "Houses") .onAppear(perform: {

                withAnimation(.easeInOut(duration: 0.5)) {


                }

            })

            VStack(){


                Text("Houses").font(.largeTitle)

            }.padding([.leading, .top], 10).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)




            Form {
                Section() {

                    Text(house.title)
                    Text(house.price)
                    Text(house.houseNumber)
                    Text(house.flatNumber)
                    Text(house.streetName)
                    Text(house.city)
                    Text(house.postCode)
                    Text(house.editInfo)
                    Text(house.UserGender)

                }


            }

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
               houseListView(viewModel: HouseViewModel(house: house), mode: .edit) { result in
                    if case .success(let action) = result, action == .delete {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
        .edgesIgnoringSafeArea(.top)

        .navigationViewStyle(StackNavigationViewStyle())
    }

}
struct HouseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let house = House(title: "",houseNumber: "",flatNumber: "",streetName: "",city: "",postCode:"",editInfo: "",price:"", UserGender: "")
        return
            NavigationView {
               HouseDetailsView(house: house)
            }
    }
}
