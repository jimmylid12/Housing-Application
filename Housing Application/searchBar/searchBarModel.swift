////
////  searchBarModel.swift
////  Housing Application
////
////  Created by James Liddle on 17/08/2022.
////
//
//import SwiftUI
//import Firebase
//
//
//
//class searchBarModel: ObservableObject
//
//
//
//
//
//
//
//
//
//{
//    @Published var datas = [dataType]()
//        
//        init() {
//            
//            let db = Firestore.firestore()
//            
//            db.collection("agent").getDocuments { (snap, err) in
//                
//                if err != nil{
//                    
//                    print((err?.localizedDescription)!)
//                    return
//                }
//                
//                for i in snap!.documents{
//                    
//                    let id = i.documentID
//                    let title = i.get("title") as! String
//                    let description = i.get("description") as! String
//                    
//                    self.datas.append(dataType(id: id, title: title, description: description))
//                }
//            }
//        }
//    }
//
//    struct dataType : Identifiable {
//        
//        var id : String
//        var title : String
//        var description : String
//    }
