//
//  customerLoginPage.swift
//  Housing Application
//
//  Created by James Liddle on 21/06/2022.
//

//what the user sees after logining

import SwiftUI
import Firebase

struct customerLoginPage: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var signOutProcessing = false
    var body: some View {
        NavigationView {
            TabView {
                       
                FeedView(posts: PostModelArray(shuffled: false) ,  title: "View Properties")
                
                    .tabItem {
                        Label("View Properties", systemImage: "house")
                    }
                
                
                
                   Contact()
                                    .tabItem {
                                        Label("Contact us", systemImage: "gear")
                                    }
                
            
                     }
            
               


                
                
               
            
            
         
   
                .navigationTitle("Gentoo Housing")
            
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        if signOutProcessing {
                            ProgressView()
                        } else {
                            Button("Sign Out") {
                                signOutUser()
                            }
                        }
                    }
                }
        }
    }
    func signOutUser() {
        signOutProcessing = true
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
            signOutProcessing = false
        }
        withAnimation {
            viewRouter.currentPage = .inital
        }
    }
}

struct customerLoginPage_Previews: PreviewProvider {
    static var previews: some View {
        customerLoginPage()
    }
}
