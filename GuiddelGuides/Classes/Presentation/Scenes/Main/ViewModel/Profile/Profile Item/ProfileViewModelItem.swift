//
//  ProfileViewModelItem.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 01.09.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

protocol ProfileViewModelItem {
    var type: ProfileViewModelItemType { get }
    var rowCount: Int { get }
    var sectionTitle: String { get }
}

extension ProfileViewModelItem {
    var rowCount: Int {
        return 1
    }
}

enum ProfileViewModelItemType {
    case image
    case info
    case logout
    case verify
    case delete
}
