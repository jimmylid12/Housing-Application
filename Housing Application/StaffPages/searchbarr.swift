//
//  searchbarr.swift
//  Housing Application
//
//  Created by James Liddle on 12/08/2022.
//

//
//  searchbarr.swift
//  Firebase_Login_SwiftUI
//
//  Created by James Liddle on 31/01/2022.


import SwiftUI
import Firebase

struct searchbarr: View {
    @ObservedObject var data = getData()
    
    var body: some View {
       
        NavigationView{
            
            ZStack(alignment: .top){
                
                GeometryReader{_ in
                    
                    // Home View....
                    Text("Home")
                    
                }.background(Color("Color").edgesIgnoringSafeArea(.all))
                
                CustomSearchBar(data: self.$data.datas).padding(.top)
                
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}


struct searchbarr_Previews: PreviewProvider {
    static var previews: some View {
        searchbarr()
    }
}

struct CustomSearchBar : View {
    
    @ObservedObject var data = getData()
    
    var body: some View {
       
        NavigationView{
            
            ZStack(alignment: .top){
                
                GeometryReader{_ in
                    
                    // Home View....
                    Text("Home")
                    
                }.background(Color("Color").edgesIgnoringSafeArea(.all))
                
                CustomSearchBar(data: self.$data.datas).padding(.top)
                
            }.navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }
}
