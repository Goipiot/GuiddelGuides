//
//  UIFont+Extension.swift
//  Guiddel
//
//  Created by Anton Danilov on 07.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

extension UIFont {

    public enum Oswald: String {
        case regular = "Regular"
        case bold = "Bold"
    }

    static func getOswald(_ type: Oswald = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "Oswald-\(type.rawValue)", size: size)!
    }

    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }

    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }

}
