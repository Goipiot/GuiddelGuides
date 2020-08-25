//
//  StorageManager.swift
//  Guiddel
//
//  Created by Anton Danilov on 26.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageManager {
    static let shared = StorageManager()
    
    // Private init
    private init() {}
    
    func uploadImage(image: UIImage, completion: @escaping (String?, Error?) -> Void) {
        var data = NSData()
        data = UIImageJPEGRepresentation(image, 0.0)! as NSData
        guard let currentUser = AuthManager.shared.getCurrentAuthUser() else { return }
        let fileName = currentUser.uid
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"

        let storageRef = Storage.storage().reference()
        storageRef.child(fileName).putData(data as Data, metadata: metaData) { (metaData, error) in
            if let error = error {
                completion(nil, error)
            } else {
                storageRef.child(fileName).downloadURL { (url, error) in
                    if let error = error {
                        completion(nil, error)
                    } else if let url = url {
                        let urlString = url.absoluteString
                        completion(urlString, nil)
                    }
                }
            }
        }
    }
    
    func deleteUserData(completion: @escaping (Error?) -> Void) {
        guard let currentUser = AuthManager.shared.getCurrentAuthUser() else { return }
        let fileName = currentUser.uid
        let storageRef = Storage.storage().reference()
        storageRef.child(fileName).delete { error in
          if let error = error {
            completion(error)
          } else {
            completion(nil)
          }
        }
    }
    
    func uploadExcursionImage(image: UIImage, label: String, completion: @escaping (String?, Error?) -> Void) {
        var data = NSData()
        data = UIImageJPEGRepresentation(image, 0.0)! as NSData
        guard let currentUser = AuthManager.shared.getCurrentAuthUser() else { return }
        let fileName = "\(currentUser)\(label)"
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"

        let storageRef = Storage.storage().reference()
        storageRef.child(fileName).putData(data as Data, metadata: metaData) { (metaData, error) in
            if let error = error {
                completion(nil, error)
            } else {
                storageRef.child(fileName).downloadURL { (url, error) in
                    if let error = error {
                        completion(nil, error)
                    } else if let url = url {
                        let urlString = url.absoluteString
                        completion(urlString, nil)
                    }
                }
            }
        }
    }
}
