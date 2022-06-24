//
//  housesListView.swift
//  Housing Application
//
//  Created by James Liddle on 19/06/2022.
//
//Page which displays all the properties/ for staff it will display all

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift

struct housesListView: View {

    @State private var showButton = false
    @StateObject var viewModel = HousesViewModel()
    @State var presentAddOrderSheet = false

  private var addButton: some View {
    Button(action: { self.presentAddOrderSheet.toggle() }) {
      Image(systemName: "plus")
        Text("Create Property")
        .foregroundColor(Color.black)
    }
  }
    
  
  private func houseRowView(house: House) -> some View {
    
    NavigationLink(destination: HouseDetailsView(house: house)) {
      VStack(alignment: .leading) {
        
       
          
      
          Text("House Number ")
            .font(.headline)
          
             Text(house.houseNumber)
          .font(.subheadline)
          
        
          Text(" flat Number ")
            .font(.headline)
          
        Text(house.flatNumber)
          .font(.subheadline)
      }
        Spacer()
        VStack(alignment: .leading){
            
            Text("City ")
              .font(.headline)


            Text(house.city)
            
              .font(.subheadline)
            
            Text("PostCode ")
              .font(.headline)
            Text(house.postCode)
          .font(.subheadline)
            
            Text("editInfo ")
              .font(.headline)
            Text(house.editInfo)
          .font(.subheadline)
         
        
            
                    

            
            
            
            
            
            
    }
      
    }
  }
  
  var body: some View {
    
    NavigationView {
       
        VStack(){
         
            TitleView(Title: "House List") .onAppear(perform: {
               
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.showButton = true
                    
                }
                
            })
           
            VStack(){
                
                
                Text("houses").font(.largeTitle)
                
                
            }.padding([.leading, .top], 10).frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
            
     
            
             List {
               
               ForEach (viewModel.houses) { house in
                 houseRowView(house: house)
               }
               .onDelete() { indexSet in
                 viewModel.removeHouses(atOffsets: indexSet)
               }
             }
               

           .navigationBarItems(trailing: addButton)
             .onAppear()
             {
               print("housesListView appears. Subscribing to data updates.")
               self.viewModel.subscribe()
             }
             .onDisappear() {
         
             }
             .sheet(isPresented: self.$presentAddOrderSheet) {
               houseListView()
               
             }
                   
           } .edgesIgnoringSafeArea(.top)
        
       
  }
    
    
    .navigationViewStyle(StackNavigationViewStyle())
    
  }
    
}

struct housesListView_Previews: PreviewProvider {
    static var previews: some View {
        housesListView()
    }
}
