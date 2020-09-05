//
//  ProfileViewModelItemType.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 01.09.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

class ProfileViewModelImageItem: ProfileViewModelItem {
    var type: ProfileViewModelItemType {
        return .image
    }
    var rowCount: Int {
        return 2
    }
    var sectionTitle: String {
        return "Музей"
    }
    var museumName: String
    
    init(museumName: String) {
        self.museumName = museumName
    }
}
