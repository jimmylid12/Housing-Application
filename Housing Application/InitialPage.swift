//
//  InitialPage.swift
//  Housing Application
//
//  Created by James Liddle on 19/06/2022.
//

//inital page displays with two buttons one for staff and one for customers


import SwiftUI

struct InitialPage: View {
    var body: some View {
     
                      NavigationView {
                        
                  VStack(spacing: 30) {
                      LogoView()
                      NavigationLink(destination: customerLogin()) {
                          Text("Customers")
                          
                      }   .frame(width: 400, height: 100, alignment: .center)
                          .background(Color.orange)
                          .foregroundColor(Color.black)
                          .cornerRadius(20)
                      
                          .navigationTitle("Gentoo Properties")
                          
                      
                    
                      
                      
                      VStack{
                        
                          NavigationLink(destination: staffLogin()) {
                              Text("Staff")
                      } .frame(width: 400, height: 100, alignment: .center)
                              .background(Color.orange)
                              .foregroundColor(Color.black)
                              .cornerRadius(20)
                  }
              }
          }
    }
      }

struct InitialPage_Previews: PreviewProvider {
    static var previews: some View {
        InitialPage()
    }
}
