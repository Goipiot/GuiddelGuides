//
//  Validator.swift
//  Guiddel
//
//  Created by Anton Danilov on 27.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

class Validator {
    
    static func isNameValid(testStr: String) -> Bool {
//        let emailRegEx = "[A-Z0-9a-z._%+-]{2,15}"
//
//        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
//        return emailTest.evaluate(with: testStr)
        let length = testStr.count
        if length > 2, length < 15 {
            return true
        } else {
            return false
        }
    }

}

