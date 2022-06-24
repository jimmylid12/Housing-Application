//
//  MotherView.swift
//  Housing Application
//
//  Created by James Liddle on 19/06/2022.
//

import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter: ViewRouter
    
    var body: some View {
        switch viewRouter.currentPage {
        case .signUpPage:
            StaffSignUp()
        case .signInPage:
            staffLogin()
        case .homePage:
            HomeView()
        case .inital:
            InitialPage()
        case .customerHomePage:
            customerLoginPage()
            
        case .houselist:
            housesListView()
            
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
