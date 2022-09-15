//
//  testPage.swift
//  Housing Application
//
//  Created by James Liddle on 15/08/2022.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage
import FirebaseFirestoreSwift


struct testPage: View {
    
  
    @State private var showButton = false
    @StateObject var viewModel = requestsModel()
    @State var presentAddOrderSheet = false
  
  
    
  private func agentRowView(agent: AgentModel) -> some View {
    

      VStack(alignment: .leading) {
     
          
          VStack(alignment: .leading) {
            
           
              Image("Logo")
                         .resizable()
                         .scaledToFit()
                          .frame(width: 300.0, height: 200.0)
              
              
              HStack{
              
              Text(agent.name)
              .font(.subheadline)
              
              Text(agent.email)
              .font(.subheadline)
              
              Text(agent.flooringType)
              .font(.subheadline)
              
              }

                
        }
    
    }

    
         }
  
  
var body: some View {
    
      
  NavigationView {
     
      VStack(){
       
          TitleView(Title: "View Requests") .onAppear(perform: {
             
            
              
          })
         
          
   
          
           List {
             
             ForEach (viewModel.agents) { agent in
                 agentRowView(agent: agent)
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
  .navigationBarTitle("title")
  .navigationBarTitleDisplayMode(.inline)
  
}
  
}
struct testPage_Previews: PreviewProvider {
    static var previews: some View {
        testPage()
    }
}
