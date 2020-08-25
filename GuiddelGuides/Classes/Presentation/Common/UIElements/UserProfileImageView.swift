//
//  UserProfileImageView.swift
//  Guiddel
//
//  Created by Anton Danilov on 26.04.2020.
//  Copyright © 2020 Razeware LLC. All rights reserved.
//
import UIKit

class UserPhotoImageView: UIImageView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = self.frame.width * 0.5
//        layer.borderWidth = 1
//        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)  as CGColor
        clipsToBounds = true
    }

}
