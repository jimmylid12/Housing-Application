//
//  Store.swift
//  AuthenticationFirebaseSwiftUI
//
//  Created by James Liddle on 13/06/2022.
//

import SwiftUI



struct Store: Codable {
    var id: String?
    let name: String
    var items: [String]? = nil
}
