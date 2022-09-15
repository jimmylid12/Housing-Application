//
//  Models.swift
//  Housing Application
//
//  Created by James Liddle on 12/08/2022.
//

import SwiftUI

import Foundation
import Combine
import FirebaseFirestore


class Models: ObservableObject {
    
    
    @Published var posts = [PostModel]()
    
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
        listenerRegistration = db.collection("posts").addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            print("No documents")
            return
          }
          
          self.posts = documents.compactMap { queryDocumentSnapshot in
            try? queryDocumentSnapshot.data(as: PostModel.self)
          }
        }
      }
    }
    
    func removeHouses(atOffsets indexSet: IndexSet) {
      let posts = indexSet.lazy.map { self.posts[$0] }
     posts.forEach { post in
        if let documentId = post.id {
          db.collection("posts").document(documentId).delete { error in
            if let error = error {
              print("Unable to remove document: \(error.localizedDescription)")
            }
          }
        }
      }
    }

    
  }
