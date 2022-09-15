//
//  testingNewView.swift
//  Housing Application
//
//  Created by James Liddle on 14/08/2022.
//

import SwiftUI

struct testingNewView: View {
    
    @State private var showButton = false
    @Environment(\.presentationMode) var presentationMode
    @State var presentEditOrderSheet = false
    var post: PostModel

    private func editButton(action: @escaping () -> Void) -> some View {
        Button(action: { action() }) {
            Text("Edit")
                .foregroundColor(.black)
        }
    }
    
    var body: some View {

    VStack(){

            TitleView(Title: "Houses") .onAppear(perform: {

                withAnimation(.easeInOut(duration: 0.5)) {


                }

            })

            VStack(){


                Text("Houses").font(.largeTitle)

            }.padding([.leading, .top], 10).frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)




            Form {
                Section() {

                    Text(post.City! )
                    Text(post.streetName! )
                    Text(post.Price! )
                    Text(post.postCode! )
                    Text(post.HouseFlat! )
                    
                }


            }

            .navigationBarItems(trailing: editButton {
                self.presentEditOrderSheet.toggle()
            })

        }
        .edgesIgnoringSafeArea(.top)

        .navigationViewStyle(StackNavigationViewStyle())
    }

}

//struct testingNewView_Previews: PreviewProvider {
//    static var previews: some View {
//        testingNewView()
//    }
//}
