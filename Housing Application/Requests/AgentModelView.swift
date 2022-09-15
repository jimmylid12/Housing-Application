//
//  AgentModelView.swift
//  Housing Application
//
//  Created by James Liddle on 16/08/2022.
//

//how the request info is added to the backend database


import Foundation
import Combine
import FirebaseFirestore

class AgentModelView: ObservableObject  {
    
    @Published var agent: AgentModel
    @Published var modified = false

    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Constructors
    
    init(agent: AgentModel = AgentModel(name: "",email: "",telephone: "",message: "",flooringType:"")) {
          
    
      self.agent = agent 
      
      self.$agent
        .dropFirst()
        .sink { [weak self] agent in
          self?.modified = true
        }
        .store(in: &self.cancellables)
    }
    
    // MARK: - Firestore
    
    private var db = Firestore.firestore()
    
    private func addHouse(_ agent: AgentModel) {
      do {
        let _ = try db.collection("agent").addDocument(from: agent)
      }
      catch {
        print(error)
      }
    }
    
    private func updateHouse(_ agent: AgentModel) {
      if let documentId = agent.id {
        do {
          try db.collection("agent").document(documentId).setData(from: agent)
        }
        catch {
          print(error)
        }
      }
    }
    
    private func updateOrAddHouse() {
      if let _ = agent.id {
        self.updateHouse(self.agent)
      }
      else {
        addHouse(agent)
      }
    }
    
    private func removeHouse() {
      if let documentId = agent.id {
        db.collection("agent").document(documentId).delete { error in
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
