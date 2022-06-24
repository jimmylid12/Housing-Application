//
//  HomeView.swift
//  Housing Application
//
//  Created by James Liddle on 19/06/2022.
//
//when staff login the tab view is displayed, allows easy access to all the pages

import SwiftUI
import Firebase

struct HomeView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    @State var signOutProcessing = false
    
    var body: some View {
        NavigationView {
            TabView {
                       
                housesListView()
                                 .tabItem {
                                     Label("View properties", systemImage: "square.and.pencil")
                                 }
 
             newViews()
                                 .tabItem {
                                     Label("UploadImage", systemImage: "iphone.rear.camera")
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
