//
//  GuideRequest.swift
//  Guiddel
//
//  Created by Anton Danilov on 03.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

struct GuideRequest: Codable {
    var user: User?
    var museumId: String?
    var date: String?
    var description: String?
    
//    init(user: User, museum: String, date: String, description: String?) {
//        self.user = user
//        self.museumId = museum
//        self.date = date
//        self.description = description
//    }
}
