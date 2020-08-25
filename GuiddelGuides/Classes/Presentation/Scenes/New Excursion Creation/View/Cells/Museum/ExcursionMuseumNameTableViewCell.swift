//
//  ExcursionMuseumNameTableViewCell.swift
//  Guiddel
//
//  Created by Anton Danilov on 13.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class ExcursionMuseumNameTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    var item: ExcursionViewModelItem? {
        didSet {
            guard let item = item as? ExcursionViewModelMuseumNameItem else { return }
            self.valueLabel.text = item.museumName
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }

}
