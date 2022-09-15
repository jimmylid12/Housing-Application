//
//  checkingVie.swift
//  Housing Application
//
//  Created by James Liddle on 14/08/2022.
//

import SwiftUI

struct checkingVie: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: newView(viewModel:BooksViewModel())) {
                Text("Hello, World!")
            }
            .navigationTitle("Navigation")
        }
    }
}

struct checkingVie_Previews: PreviewProvider {
    static var previews: some View {
        checkingVie()
    }
}
