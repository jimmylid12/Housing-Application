//
//  AuthService.swift
//  Housing Application
//
//
//

// Used to auth users in firebase and handle user accounts
import Foundation
import FirebaseAuth
import FirebaseFirestore
import UIKit

let DB_BASE = Firestore.firestore()
class AuthService
{
    static let instance = AuthService()
    private var REF_USERS = DB_BASE.collection("users")
    

}
