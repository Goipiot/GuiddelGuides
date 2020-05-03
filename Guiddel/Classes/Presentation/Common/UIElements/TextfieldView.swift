//
//  TextfieldView.swift
//  Guiddel
//
//  Created by Anton Danilov on 26.04.2020.
//  Copyright © 2020 Razeware LLC. All rights reserved.
//

import UIKit

class TextfieldView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
    }

}
