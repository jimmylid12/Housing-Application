//
//  MultipleImageFetcher.swift
//  Housing Application
//
//  Created by James Liddle on 10/07/2022.
//

import SwiftUI

class MultipleImageFetcher: ObservableObject {
    var firebaseManager: FirebaseManager
    var imageDictionary: [String: UIImage] = [:]
    @Published var isReady = false


    init(_ firebaseManager: FirebaseManager) {
        self.firebaseManager = firebaseManager
    }

    func fetchAllImages(references: [String]) {
        for refID in references {
            fetchIndividualImage(id: refID, totalNum:
    references.count)
        }
    }

    func fetchIndividualImage(id: String, totalNum: Int) {
        let ref = getRefURL(uid: id)
        ref.getData(maxSize: 2051240) { data, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            self.imageDictionary[id] = UIImage(data: data!)
            self.checkIsReady(num: totalNum)
        }
    }

    func getRefURL(uid: String) -> StorageReference {
        return firebaseManager.STORAGE.reference().child(uid)
    }

    func checkIsReady(num: Int) {
        if imageDictionary.count == num {
            self.isReady = true
        } else {
            self.isReady = false
        }
    }
}



struct ImageView: View {
    @ObservedObject var fetcher: MultipleImageFetcher

    init(_ firebaseManager: FirebaseManager) {
        self.fetcher = MultipleImageFetcher(firebaseManager)
    }


    var body: some View {

        Button {
            fetcher.fetchAllImages(references:
["KXKFM94sk5OTyld2VsCQdhijd6m1", "MtgRaKMwyQfYX2uxuHs3iH3pLB52"])
        } label: {
            Text("Load Image")
        }

        if fetcher.isReady {
            Text("Is Ready")
        } else {
            Text("Loading...")
        }
    }
}
