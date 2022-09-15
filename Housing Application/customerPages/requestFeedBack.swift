//
//  requestFeedBack.swift
//  Housing Application
//
//  Created by James Liddle on 31/08/2022.
//

import SwiftUI

struct requestFeedBack: View {
    
    var post: PostModel
    var body: some View {
        HStack{
            Button(action: {
                
            }, label: {
                NavigationLink(destination: EmailAgent(post: post)) {
                    Text("Request Changes")
                    
                        .padding(30)
                        .padding(.bottom, 10)
                        .frame(width: 200, height: 50 )                        .foregroundColor(.white)
                        .background(Color("lightpurple"))
                    
                }
            })}
    }
}

//struct requestFeedBack_Previews: PreviewProvider {
//    static var previews: some View {
//        requestFeedBack()
//    }
//}
