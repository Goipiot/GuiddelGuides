//
//  DatabaseManager.swift
//  Guiddel
//
//  Created by Anton Danilov on 27.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation
import FirebaseStorage
import FirebaseFirestoreSwift
import Firebase

class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let userDB = Firestore.firestore().collection("users")
    
    private let decoder = JSONDecoder()
    
    // Private init
    private init(){}
    
    func createUser(user: FirebaseAuth.User, completion: @escaping (Error?) -> Void) {
        let currentUser = user
        userDB.document(currentUser.uid).setData([
            "lastUpdated": FieldValue.serverTimestamp(),
            "email": currentUser.email]) { err in
                if let err = err {
                    completion(err)
                } else {
                    completion(nil)
                }
        }
    }
    
    func updateUser(name: String, image: String, completion: @escaping (Error?) -> Void) {
        let userID = AuthManager.shared.getCurrentAuthUser().uid
        userDB.document(userID).updateData([
            "lastUpdated": FieldValue.serverTimestamp(),
            "displayName": name,
            "photoURL": image]) { err in
                if let err = err {
                    completion(err)
                } else {
                    completion(nil)
                }
        }
        
    }
    
    func getUser(completion: @escaping (User?, Error?) -> Void ) {
        let userID = AuthManager.shared.getCurrentAuthUser().uid
        
        let docRef = userDB.document(userID)
        docRef.getDocument { (document, error) in
            if let error = error {
                completion(nil, error)
                return
            }
            let result = Result {
                try document?.data(as: User.self)
            }
            switch result {
            case .success(let user):
                if let user = user {
                    completion(user, nil)
                } else {
                    completion(nil, error)
                }
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getUserUpdates(completion: @escaping (User?, Error?) -> Void ) {
        let userID = AuthManager.shared.getCurrentAuthUser().uid
        userDB.document(userID).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                return
            }
            guard let userDict = document.data() else {
                return
            }
            let email = userDict["email"] as? String
            let photoURL = userDict["photoURL"] as? String
            let displayName = userDict["displayName"] as? String
            
            let userModel = User(uid: userID, email: email ?? "", displayName: displayName, photoURL: photoURL)
            print(userModel)
            completion(userModel, error)
        }
    }
    
    func deleteUserData(completion: @escaping (Error?) -> Void) {
        let userID = AuthManager.shared.getCurrentAuthUser().uid
        userDB.document(userID).delete() { err in
            if let err = err {
                completion(err)
            } else {
                completion(nil)
            }
        }
    }
    
    func getAllUsers(completion: @escaping (Error?, [User]?) -> Void) {
        userDB.getDocuments() { (querySnapshot, err) in
            if let err = err {
                completion(err, nil)
            } else {
                var userArray: [User] = []
                for document in querySnapshot!.documents {
                    do {
                        let jsonData = try? JSONSerialization.data(withJSONObject:document.data())
                        let user = try self.decoder.decode(User.self, from: jsonData!)
                        userArray.append(user)
                    } catch let error  {
                        completion(error, nil)
                    }
                }
                completion(nil, userArray)
            }
        }
    }
}


extension QueryDocumentSnapshot {
    func decoded<Type: Decodable>() throws -> Type {
        let jsonData = try JSONSerialization.data(withJSONObject: data(), options: [])
        let object = try JSONDecoder().decode(Type.self, from: jsonData)
        return object
    }
}

extension QuerySnapshot {
    func decoded<Type: Decodable>() throws -> [Type] {
        let objects: [Type] = try documents.map({try $0.decoded() })
        return objects
    }
}
