//
//  AccountManager.swift
//  Guiddel
//
//  Created by Anton Danilov on 26.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation
import FirebaseStorage
import Firebase

class AccountManager {
    static let shared = AccountManager()
    
    func updateUserInfo(displayName: String, image: UIImage, completion: @escaping(Error?) -> Void) {
        StorageManager.shared.uploadImage(image: image) { imageURL, error in
            if let imageURL = imageURL, error == nil {
                let photoURL = imageURL
                UserFirestoreManager.shared.updateUser(name: displayName, image: photoURL) { error in
                    if let error = error {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                }
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
    
    
    // Private init
    private init(){}
    
    
    //    func updateUserInfo(displayName: String?, image: UIImage?, completion: @escaping(Error?) -> Void) {
    //        let changeRequest = currentAccount.createProfileChangeRequest()
    //        if let name = displayName {
    //            changeRequest.displayName = name
    //            changeRequest.commitChanges { (error) in
    //                if let error = error {
    //                    completion(error)
    //                }
    //            }
    //        }
    //        if let image = image {
    //            StorageManager.shared.uploadImage(image: image) { imageURL, error in
    //                if let imageURL = imageURL, error == nil {
    //                    changeRequest.photoURL = imageURL
    //                    changeRequest.commitChanges { (error) in
    //                        if let error = error {
    //                            completion(error)
    //                        }
    //                    }
    //                } else {
    //                    completion(error)
    //                }
    //            }
    //        }
    //        let currentUserRef = usersRef.child(currentAccount.uid)
    //        currentUserRef.setValue(self.user.email)
    //
    //    }
    
}
