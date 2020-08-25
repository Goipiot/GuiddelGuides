//
//  Excursion.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 07.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

struct Excursion: Codable {
    var participants: [String: User] = [:]
    var guide: User?
    var groupLimit: Int = 10
    var date: String = ""
    var museum: Museum = Museum()
    //    var status: ExcursionStatus = ExcursionStatus()
    var title: String = ""
    var price: Int = 250
    var imageURL: String = ""
    var day: String = ""
}

struct ExcursionStatus: Codable {
    var isStarted: Bool = false
    var isEnded: Bool = false
    var isDeclined: Bool = false
    var isWaiting: Bool = true
}
