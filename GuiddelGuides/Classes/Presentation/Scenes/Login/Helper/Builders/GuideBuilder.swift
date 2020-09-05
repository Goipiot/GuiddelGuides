//
//  GuideBuilder.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 01.09.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation
import UIKit

class GuideBuilder {
    
    private init() {}
    
    static let shared = GuideBuilder()
    
    private var guide = Guide()
    private var photo = UIImage()
    
    func reset() {
        guide = Guide()
        photo = UIImage()
    }
    
    func setAuthData(authData: User) {
        guide.gid = authData.uid
        guide.email = authData.email
    }
    
    func build() -> Guide {
        return guide
    }
}
