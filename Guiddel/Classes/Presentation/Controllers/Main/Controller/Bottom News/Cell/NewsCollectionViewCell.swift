//
//  NewsCollectionViewCell.swift
//  Guiddel
//
//  Created by Anton Danilov on 02.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var museumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    // MARK: - Private Methods
    private func setup() {
        self.layer.cornerRadius = 15
//        self.layer.borderWidth = 1.0
//        self.layer.borderColor = UIColor.lightGray.cgColor

//        self.layer.backgroundColor = UIColor.white.cgColor
//        self.layer.shadowColor = UIColor.gray.cgColor
//        self.layer.shadowOffset = CGSize(width: 2.0, height: 4.0)
//        self.layer.shadowRadius = 2.0
//        self.layer.shadowOpacity = 1.0
//        self.layer.masksToBounds = false
        contentView.layer.cornerRadius = 15
        museumImageView.clipsToBounds = true
    }
}
