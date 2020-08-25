//
//  ExcursionRoundView.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 16.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class ExcursionRoundView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners([.topLeft, .topRight], radius: 20)
        self.layer.masksToBounds = false
    }
    
}
