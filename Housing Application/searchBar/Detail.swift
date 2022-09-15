//
//  Detail.swift
//  Housing Application
//
//  Created by James Liddle on 13/09/2022.
//

//what the searchbar page goes to after clicking on a request. This is just a rough copy

import SwiftUI

struct Detail: View {
    var data : AgentModel
    
    var body : some View{
        VStack (spacing: 50){
         
            Text("CUSTOMER DETAILS")
                .underline()
                .font(.system(size: 40))
       
            Text("customer Name")
                   
            Text(data.name)
                
                
      
            Text("customer Number")
            Text(data.telephone)
//                .font(.title)
             
          
            Text("customer FloorType")
            Text(data.flooringType)
              
          
       
            Text("customer Email")
            Text(data.email)
            
            
           
//                .fontWeight(.bold)
            }
            Spacer()
        }
}

//struct Detail_Previews: PreviewProvider {
//    static var previews: some View {
//        Detail()
//    }
//}
