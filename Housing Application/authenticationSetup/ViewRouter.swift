//
//  ViewRouter.swift
//  Housing Application
//
//  Created by James Liddle on 19/06/2022.
//


import SwiftUI

class ViewRouter: ObservableObject {
    
    @Published var currentPage: Page = .inital
    
}

enum Page {
    case signUpPage
    case signInPage
    case homePage
    case inital
    case customerHomePage
    case houselist
}

