//
//  newModel.swift
//  Housing Application
//
//  Created by James Liddle on 13/08/2022.
//

import SwiftUI
import Combine
import FirebaseFirestore

class newModel:  ObservableObject{
    
    
    @Published var post: PostModel
    @Published var modified = false
    
    private var cancellables = Set<AnyCancellable>()
    
    
    init(post: PostModel = PostModel(postId: "", userId: "", username: "Joe Breen", caption: "Test Caption1", streetName:  "kjkj", HouseFlat:"kjkj", Price:"1234",  likeCount: 0, dateCreate: Date(), likedByUser: false)){
    
    
  self.post = post
  
  self.$post
    .dropFirst()
    .sink { [weak self] post in
      self?.modified = true
    }
    .store(in: &self.cancellables)
}

// MARK: - Firestore

private var db = Firestore.firestore()

private func addHouse(_ post: PostModel) {
  do {
    let _ = try db.collection("posts").addDocument(from: post)
  }
  catch {
    print(error)
  }
}

private func updateHouse(_ post: PostModel) {
    if let documentId = post.id {
    do {
      try db.collection("posts").document(documentId).setData(from: post)
    }
    catch {
      print(error)
    }
  }
}

private func updateOrAddHouse() {
    if let _ = post.id{
    self.updateHouse(self.post)
  }
  else {
    addHouse(post)
  }
}

private func removeHouse() {
  if let documentId = post.id{
    db.collection("posts").document(documentId).delete { error in
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
