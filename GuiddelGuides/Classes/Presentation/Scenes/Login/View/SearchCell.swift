//
//  SearchCell.swift
//  Guiddel
//
//  Created by Anton Danilov on 30.04.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    // MARK: - IBOutlets
//    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        subTitleLabel.textColor = #colorLiteral(red: 0.2156862745, green: 0.2431372549, blue: 0.9411764706, alpha: 1)
    }

}
