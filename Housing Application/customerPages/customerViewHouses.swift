//
//  customerViewHouses.swift
//  Housing Application
//
//  Created by James Liddle on 21/06/2022.
//

import SwiftUI

struct customerViewHouses: View {

    @StateObject var viewModel = HousesViewModel()
    @State var presentAddOrderSheet = false

  
  private func houseRowView(house: House) -> some View {
    
    NavigationLink(destination: requestEdits(house: house)) {
      VStack(alignment: .leading) {
        
  
          Text("House Number ")
            .font(.headline)
          
                  Text(house.houseNumber)
          .font(.subheadline)
          
        
          Text("flat Number ")
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
