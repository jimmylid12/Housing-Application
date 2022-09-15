//
//  searchBarPage.swift
//  Housing Application
//
//  Created by James Liddle on 17/08/2022.
//

//this is just a test to see how a searchbarpage could work

import SwiftUI
import Firebase

struct searchBarPage: View {
    @State var search = ""
        
        @ObservedObject var data = getData()
        
        var body: some View {
           
            NavigationView{
                List {
     
                    ForEach(self.data.datas.filter{(self.search.isEmpty ? true : $0.name.localizedCaseInsensitiveContains(self.search))}, id: \.id) { rs in
                        
                        NavigationLink(destination: Detail(data: rs)) {
                            Text(rs.name)
                        }
                    }
                }
                .navigationBarTitle("Search requests")
                .searchable(text: self.$search)
                {
                    ForEach(data.datas, id:\.id) { info in
                                       HStack {
                                           Text(info.name)
                                               .searchCompletion(info.name)
                  
                                       }
                                   }
                               }
                           }
                       }
                   }

struct searchBarPage_Previews: PreviewProvider {
    static var previews: some View {
        searchBarPage()
    }
}


