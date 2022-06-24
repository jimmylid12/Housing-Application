//
//  HouseViewModel.swift
//  Housing Application
//
//  Created by James Liddle on 19/06/2022.
//

//This is how an order is uploaded to firebase

import Foundation
import Combine
import FirebaseFirestore
class HouseViewModel: ObservableObject  {
    
    @Published var house: House
    @Published var modified = false

    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructors
    
    init(house: House = House(title: "",houseNumber: "",flatNumber: "",streetName: "",city: "",postCode: "", editInfo: "")) {
          
          
        
      self.house = house
      
      self.$house
        .dropFirst()
        .sink { [weak self] house in
          self?.modified = true
        }
        .store(in: &self.cancellables)
    }
    
    // MARK: - Firestore
    
    private var db = Firestore.firestore()
    
    private func addHouse(_ house: House) {
      do {
        let _ = try db.collection("houses").addDocument(from: house)
      }
      catch {
        print(error)
      }
    }
    
    private func updateHouse(_ house: House) {
      if let documentId = house.id {
        do {
          try db.collection("houses").document(documentId).setData(from: house)
        }
        catch {
          print(error)
        }
      }
    }
    
    private func updateOrAddHouse() {
      if let _ = house.id {
        self.updateHouse(self.house)
      }
      else {
        addHouse(house)
      }
    }
    
    private func removeHouse() {
      if let documentId = house.id {
        db.collection("houses").document(documentId).delete { error in
          if let error = error {
            print(error.localizedDescription)
          }
        }
      }
    }
    
    // MARK: - UI handlers
    
    func handleDoneTapped() {
      self.updateOrAddHouse()
    }
    
    func handleDeleteTapped() {
      self.removeHouse()
    }
    
  }
