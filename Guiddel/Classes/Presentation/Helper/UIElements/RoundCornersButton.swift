//
//  RoundCornersButton.swift
//  Guiddel
//
//  Created by Anton Danilov on 28.04.2020.
//  Copyright © 2020 Razeware LLC. All rights reserved.
//

import UIKit

class RoundCornersButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
        clipsToBounds = true
    }

}
