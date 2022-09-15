//
//  Book.swift
//  Housing Application
//
//  Created by James Liddle on 13/08/2022.
//

import SwiftUI

import Foundation
import FirebaseFirestoreSwift
 
struct Book: Identifiable, Codable {
  @DocumentID var id: String?
  var title: String
  var author: String
  var numberOfPages: Int
  var image: String
   
  enum CodingKeys: String, CodingKey {
    case id
    case title
    case author
    case numberOfPages = "pages"
    case image
  }
}
