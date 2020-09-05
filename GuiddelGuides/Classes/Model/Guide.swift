//
//  Guide.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 01.09.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation
import Firebase

struct Guide: Codable {
    
    var gid: String? = "N/A"
    var email: String? = "N/A"
    var displayName: String? = "N/A"
    var photoURL: String? = "N/A"
    var notificationToken: String? = "N/A"
    var museumID: String? = "N/A"
    
    
//    
//    init(authData: Firebase.User) {
//        gid = authData.uid
//        email = authData.email!
//        displayName = authData.displayName
//        photoURL = authData.photoURL?.absoluteString
//    }
//
//    init (uid: String, email: String, displayName: String?, photoURL: String?) {
//        self.gid = uid
//        self.email = email
//        self.displayName = displayName
//        self.photoURL = photoURL
//    }
    
}
