//
//  AuthManager.swift
//  Guiddel
//
//  Created by Anton Danilov on 27.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthManager {
    
    static let shared = AuthManager()
    
    private var currentAuthUser: FirebaseAuth.User! 
    
    private init () {}
    
    func getCurrentAuthUser() -> FirebaseAuth.User {
        return currentAuthUser
    }
    
    func updateCurrentUser(with user: FirebaseAuth.User) {
        currentAuthUser = user
    }
    
    func signIn(email: String, password: String, completion: @escaping(Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { user, error in
            if let user = user, error == nil {
                guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
                appDel.logIn()
                completion(nil)
            } else {
                completion(error)
            }
            
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping(Error?) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { user, error in
            if error == nil, let user = user {
                DatabaseManager.shared.createUser(user: user.user) { error in
                    if let error = error {
                        completion(error)
                    } else {
                        self.signIn(email: email, password: password) { error in
                            if let error = error {
                                completion(error)
                            }
                        }
                        completion(nil)
                    }
                }
            } else {
                completion(error)
            }
        }
    }
    
    func logOut(completion: @escaping (Error?) -> Void) {
        do {
          try Auth.auth().signOut()
            guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
            appDel.logOut()
            completion(nil)
        } catch (let error) {
          completion(error)
        }
    }
    
    func deleteAccount(completion: @escaping (Error?) -> Void) {
        let user = currentAuthUser
        StorageManager.shared.deleteUserData { error in
            if let error = error {
                completion(error)
            } else {
                DatabaseManager.shared.deleteUserData { error in
                    if let error = error {
                        completion(error)
                    } else {
                        user?.delete { error in
                            if let error = error {
                                completion(error)
                            } else {
                                self.logOut { error in
                                    if let error = error {
                                        completion(error)
                                    } else {
                                        completion(nil)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
