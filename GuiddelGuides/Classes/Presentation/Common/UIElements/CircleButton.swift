//
//  CircleButton.swift
//  Guiddel
//
//  Created by Anton Danilov on 25.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class CircleButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width * 0.5
        clipsToBounds = true
    }
}
