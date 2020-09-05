//
//  DatabaseManager.swift
//  Guiddel
//
//  Created by Anton Danilov on 27.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//
import Firebase
import FirebaseFirestoreSwift

class UserFirestoreManager {
    static let shared = UserFirestoreManager()
    
    private let userDB = Firestore.firestore().collection("guides")
    
    private let decoder = JSONDecoder()
    
    // Private init
    private init() {}
    
    func createUser(user: FirebaseAuth.User, completion: @escaping (Error?) -> Void) {
        userDB.document(user.uid).setData([
            "uid": user.uid,
            "lastUpdated": FieldValue.serverTimestamp(),
            "email": user.email]) { err in
                if let err = err {
                    completion(err)
                } else {
                    completion(nil)
                }
        }
    }
    
    func updateUser(name: String, image: String, completion: @escaping (Error?) -> Void) {
        guard let currentUser = AuthManager.shared.getCurrentAuthUser() else { return }
        let userID = currentUser.uid
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
        guard let currentUser = AuthManager.shared.getCurrentAuthUser() else { return }
        let userID = currentUser.uid
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
    
    func getUser(with uid: String, completion: @escaping (User?, Error?) -> Void ) {
        let docRef = Firestore.firestore().collection("users").document(uid)
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
        guard let currentUser = AuthManager.shared.getCurrentAuthUser() else { return }
        let userID = currentUser.uid
        userDB.document(userID).addSnapshotListener { documentSnapshot, err in
            if let err = err {
                completion(nil, err)
            } else {
                guard let document = documentSnapshot else {
                    return
                }
                do {
                    let user = try document.data(as: User.self)!
                    print(user)
                    completion(user, nil)
                } catch let error {
                    completion(nil, error)
                }
            }

        }
    }
    
    public func addUserNotificationToken(token: String) {
          guard let currentUser = AuthManager.shared.getCurrentAuthUser() else { return }
          let userID = currentUser.uid
          // Обновление данных текущего пользователя
          userDB.document(userID).updateData([
              "lastUpdated": FieldValue.serverTimestamp(),
              "notificationToken": token]) { err in
                  if let err = err {
                      print(err)
                  }
          }
      }
    
    func deleteUserData(completion: @escaping (Error?) -> Void) {
        guard let currentUser = AuthManager.shared.getCurrentAuthUser() else { return }
        let userID = currentUser.uid
        userDB.document(userID).delete { err in
            if let err = err {
                completion(err)
            } else {
                completion(nil)
            }
        }
    }
    
    func verifyGuide(museumId: String, completion: @escaping(Error?) -> Void) {
        guard let currentUser = AuthManager.shared.getCurrentAuthUser() else { return }
        let userID = currentUser.uid
        userDB.document(userID).updateData([
            "lastUpdated": FieldValue.serverTimestamp(),
            "mid": museumId]) { err in
                if let err = err {
                    print(err)
                }
        }
    }
    
    func addUserRequest(requestID: String, completion: @escaping (Error?) -> Void) {
        guard let currentUser = AuthManager.shared.getCurrentAuthUser() else { return }
        let userID = currentUser.uid
        userDB.document(userID).updateData([
            "request": requestID]) { err in
                if let err = err {
                    completion(err)
                } else {
                    completion(nil)
                }
        }
    }
    
    func addExcursion(excursion: Excursion, excursionID: String, userID: String, completion: @escaping (Error?) -> Void) {
        let userinoDB = Firestore.firestore().collection("users")
        guard let currentUser = AuthManager.shared.getCurrentAuthUser() else { return }
        let guideID = currentUser.uid
        do {
            try userDB.document(guideID).collection("excursions").document(excursionID).setData(from: excursion)
            try userinoDB.document(userID).collection("excursions").document(excursionID).setData(from: excursion)
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
}
