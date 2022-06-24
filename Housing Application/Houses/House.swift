//
//  House.swift
//  Housing Application
//
//  Created by James Liddle on 19/06/2022.
//

//information which is used to create property details


import Foundation
import FirebaseFirestoreSwift

struct House: Identifiable, Codable {
  @DocumentID var id: String?
    var title: String
    var houseNumber: String
    var  flatNumber: String
    var streetName: String
    var city: String
    var postCode: String
    var editInfo: String
    
    enum CodingKeys: String, CodingKey {
      case id
      case title
      case houseNumber
      case flatNumber
      case streetName
      case city
      case postCode
      case editInfo
  
    }
    
    
}
