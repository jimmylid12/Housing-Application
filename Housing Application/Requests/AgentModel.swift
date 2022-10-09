//
//  AgentModel.swift
//  Housing Application
//
//  Created by James Liddle on 16/08/2022.
//
//This is what gets uploaded when customers create a request for the agent/staff so that then they
//can view it



import SwiftUI
import Foundation
import FirebaseFirestoreSwift

import Firebase

class getData : ObservableObject {
    
    @Published var datas = [AgentModel]()
    
    init() {
        
        let db = Firestore.firestore()
        
        db.collection("agent").getDocuments { (snap, err) in
            
            if err != nil{
                
                print((err?.localizedDescription)!)
                return
            }
            
            for i in snap!.documents{
                
                let id = i.documentID
                let name = i.get("name") as! String
                let telephone = i.get("telephone") as! String
                let email = i.get("email") as! String
                let message = i.get("message") as! String
                let flooringType = i.get("flooringType") as! String
                
                self.datas.append(AgentModel(id: id, name: name, email: email,telephone: telephone, message:message, flooringType: flooringType))
            }
        }
    }
}


struct AgentModel: Identifiable, Codable {
    

    @DocumentID var id: String?
    var name: String
    var email: String
    var telephone : String
    var message: String
    var flooringType: String
      
      
      enum CodingKeys: String, CodingKey{
          case id
          case name
          case email
          case telephone
          case  message
          case  flooringType
    
      }
      
      
  }
