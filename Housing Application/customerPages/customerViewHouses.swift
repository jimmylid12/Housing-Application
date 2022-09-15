//
//  customerViewHouses.swift
//  Housing Application
//
//  Created by James Liddle on 21/06/2022.
//

//where all the houses are be able to be views

import SwiftUI

struct customerViewHouses: View {

    @StateObject var viewModel = HousesViewModel()
    @State var presentAddOrderSheet = false

  
  private func houseRowView(house: House) -> some View {
    
    NavigationLink(destination: requestEdits(house: house)) {
      VStack(alignment: .leading) {
        
  
          VStack(alignment: .leading) {
            
           
              Image("Logo")
                         .resizable()
                         .scaledToFit()
                          .frame(width: 300.0, height: 200.0)
              HStack{
              
              Text("House ")
                .font(.headline)
              
              Text(house.title)
              .font(.subheadline)
                  
                  
                  Text(house.editInfo)
                  .font(.subheadline)
                  .foregroundColor(.green)
                  
                  
              }
              HStack{
                  
                  
                  Text(house.streetName)
                  .font(.subheadline)
                  
                  Spacer()
                  
                  Text(house.postCode)
                  .font(.subheadline)
                  
                  
              }
             
            
                
                        

                
                
                
                
                
                
        }
      
         
        
    }
      
    }
  }
  
  var body: some View {
    
    NavigationView {
       
        VStack(){
         
            TitleView(Title: "House List") .onAppear(perform: {
               
              
                
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
struct customerViewHouses_Previews: PreviewProvider {
    static var previews: some View {
        customerViewHouses()
    }
}
