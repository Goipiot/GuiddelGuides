//
//  NoExcursionsView.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 14.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

protocol NoExcursionsViewDelegate: class {
    func userPressedCreationButton()
}

class NoExcursionsView: UIView {
    
    weak var delegate: NoExcursionsViewDelegate?
    
    @IBAction func creationButtonPressed(_ sender: RoundCornersButton) {
        delegate?.userPressedCreationButton()
    }
    
}
