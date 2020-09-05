//
//  Museum.swift
//  Guiddel
//
//  Created by Anton Danilov on 07.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

struct Museum: Codable {
    var mid: String? = "N/A"
    var name: String? = "N/A"
    var photoURL: String? = "N/A"
    var coordinates: [Double]? = []
    var workingSchedule: [String: WorkingSchedule]? = [:]
    var lastUpdate: String? = "N/A"
    var secretCode: String? = "N/A"
}
