//
//  ExcursionSizeTableViewCell.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 16.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class ExcursionSizeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var item: ExcursionViewModelItem? {
        didSet {
            guard let item = item as? ExcursionViewModelSizeItem else { return }
            self.valueLabel.text = "\(item.size)"
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
