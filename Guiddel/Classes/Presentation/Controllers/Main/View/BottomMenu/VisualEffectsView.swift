//
//  VisualEffectsView.swift
//  Guiddel
//
//  Created by Anton Danilov on 30.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class VisualEffectsView: UIVisualEffectView {
    // For iOS 10 only
    private lazy var shadowLayer: CAShapeLayer = CAShapeLayer()
    
    override func layoutSubviews() {
        if #available(iOS 11, *) {
        } else {
            layer.cornerRadius = 9.0
            clipsToBounds = true
            layer.insertSublayer(shadowLayer, at: 0)
            let rect = frame
            let path = UIBezierPath(roundedRect: rect,
                                    byRoundingCorners: [.topLeft, .topRight],
                                    cornerRadii: CGSize(width: 9.0, height: 9.0))
            shadowLayer.frame = frame
            shadowLayer.shadowPath = path.cgPath
            shadowLayer.shadowColor = UIColor.black.cgColor
            shadowLayer.shadowOffset = CGSize(width: 0.0, height: 1.0)
            shadowLayer.shadowOpacity = 0.2
            shadowLayer.shadowRadius = 3.0
        }
    }
}
