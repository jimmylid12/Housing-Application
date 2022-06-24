//
//  HousesViewModel.swift
//  Housing Application
//
//  Created by James Liddle on 19/06/2022.

//This is the page which allows you to update the app which firebase will then deal with

import Foundation
import Combine
import FirebaseFirestore

class HousesViewModel: ObservableObject {
    @Published var houses = [House]()
    
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
        listenerRegistration = db.collection("houses").addSnapshotListener { (querySnapshot, error) in
          guard let documents = querySnapshot?.documents else {
            print("No documents")
            return
          }
          
          self.houses = documents.compactMap { queryDocumentSnapshot in
            try? queryDocumentSnapshot.data(as: House.self)
          }
        }
      }
    }
    
    func removeHouses(atOffsets indexSet: IndexSet) {
      let houses = indexSet.lazy.map { self.houses[$0] }
      houses.forEach { house in
        if let documentId = house.id {
          db.collection("houses").document(documentId).delete { error in
            if let error = error {
              print("Unable to remove document: \(error.localizedDescription)")
            }
          }
        }
      }
    }

    
  }
