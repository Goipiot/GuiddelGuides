//
//  BaseError.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

enum BaseError: String, Error {
    case invalidData = "Invalid data"
    case parseError = "Invalid request"
    case networkError = "Network error"
    case invalidToken = "Auth failed"
}
