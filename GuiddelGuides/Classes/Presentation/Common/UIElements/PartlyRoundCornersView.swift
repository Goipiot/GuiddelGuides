//
//  PartlyRoundCornersView.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 23.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class PartlyRoundCornersView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners([.topRight, .bottomLeft], radius: 20)
    }
}
