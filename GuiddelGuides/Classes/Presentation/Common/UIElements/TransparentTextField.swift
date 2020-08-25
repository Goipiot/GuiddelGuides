//
//  TransparentTextField.swift
//  Guiddel
//
//  Created by Anton Danilov on 06.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class TransparentTextField: UITextField {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.cornerRadius = 20
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)  as CGColor
        setLeftPaddingPoints(10)
        font = UIFont.getOswald(.regular, size: 17)
        
        textColor = .white
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
}
