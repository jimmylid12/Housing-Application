//
//  Contact.swift
//  Housing Application
//
//  Created by James Liddle on 18/08/2022.
//

//simple contact page for user to see


import SwiftUI

struct Contact: View {
    var body: some View {
        VStack{
        Text("Contact us")
            Spacer()
            Text("Email Address")
            Text("GentooHousing@homes.com")
            Spacer()
            Text("Phone Nunber")
            Text("01942345434")
            Spacer()
 
        }
    }
}

struct Contact_Previews: PreviewProvider {
    static var previews: some View {
        Contact()
    }
}
