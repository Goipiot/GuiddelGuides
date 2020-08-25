//
//  ExcursionPriceViewController.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 15.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class ExcursionPriceViewController: ExcursionCreationViewController {
    
    override func nextButtonPressed(_ sender: Any) {
        guard let text = textField.text,
            let value = Int(text) else { return }
        ExcursionBuilder.shared.setPrice(price: value)
        performSegue(withIdentifier: "showGroupScreen", sender: self)
    }
    
}
