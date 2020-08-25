//
//  GuideRequest.swift
//  Guiddel
//
//  Created by Anton Danilov on 03.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

struct GuideRequest: Codable {
    var reqId: String?
//    var user: User
    var userId: String
    var museum: Museum
    var date: String
    let price: Double = 2500
    let status: String = "Pending"
}
