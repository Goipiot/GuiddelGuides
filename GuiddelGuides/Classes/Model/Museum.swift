//
//  Museum.swift
//  Guiddel
//
//  Created by Anton Danilov on 07.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

struct Museum: Codable {
    var name: String = ""
    var photoURL: String = ""
    var coordinates: [Double] = []
    var workingSchedule: [String: WorkingSchedule]? = [:]
    var lastUpdate: String? = ""
}
