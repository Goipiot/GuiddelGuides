//
//  User.swift
//  Guiddel
//
//  Created by Anton Danilov on 30.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation
import Firebase

struct User: Codable {
    
    let email: String
    var displayName: String?
    var photoURL: String?
    
    init(authData: Firebase.User) {
        print(authData)
        email = authData.email!
        displayName = authData.displayName
        photoURL = authData.photoURL?.absoluteString
    }
    init (uid: String, email: String, displayName: String?, photoURL: String?){
        self.email = email
        self.displayName = displayName
        self.photoURL = photoURL
    }
    
}
