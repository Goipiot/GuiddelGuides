//
//  RoundCornersImage.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 15.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation
import UIKit

class RoundCornersImage: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
        clipsToBounds = true
    }
    
}
