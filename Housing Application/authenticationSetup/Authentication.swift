//
//  Authentication.swift
//  Housing Application
//
//  Created by James Liddle on 19/06/2022.
//

import SwiftUI
import Firebase

@main
struct AuthenticationFirebaseSwiftUIApp: App {
    
    @StateObject var viewRouter = ViewRouter()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MotherView().environmentObject(viewRouter)
        }
    }
}
