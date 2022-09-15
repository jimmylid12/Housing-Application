//
//  requestsModel.swift
//  Housing Application
//
//  Created by James Liddle on 16/08/2022.
//

//agent model uses this to maintain what is happening

import Foundation
import Combine
import FirebaseFirestore

class requestsModel: ObservableObject  {
    
    @Published var agents = [AgentModel]()
    
    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?
    
    deinit {
      unsubscribe()
    }
    
    func unsubscribe() {
      if listenerRegistration != nil {
        listenerRegistration?.remove()
        listenerRegistration = nil
      }
    }
    
    func subscribe() {
      if listenerRegistration == nil {
        listenerRegistration = db.collection("agent").addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            print("No documents")
            return
          }
          
          self.agents = documents.compactMap { queryDocumentSnapshot in
            try? queryDocumentSnapshot.data(as: AgentModel.self)
          }
        }
      }
    }
    
    func removeHouses(atOffsets indexSet: IndexSet) {
      let agents = indexSet.lazy.map { self.agents[$0] }
      agents.forEach { agent in
        if let documentId = agent.id {
          db.collection("agent").document(documentId).delete { error in
            if let error = error {
              print("Unable to remove document: \(error.localizedDescription)")
            }
          }
        }
      }
    }

    
  }
