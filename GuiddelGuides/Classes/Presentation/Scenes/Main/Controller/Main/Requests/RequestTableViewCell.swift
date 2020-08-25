//
//  RequestTableViewCell.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 07.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

protocol RequestTableViewCellDelegate: class {
    func userAcceptedRequest()
}

class RequestTableViewCell: UITableViewCell {
    
    @IBOutlet weak var museumPhotoImageView: UserPhotoImageView!
    @IBOutlet weak var museumNameLabel: UILabel!
    @IBOutlet weak var requestUserNameLabel: UILabel!
    
    weak var delegate: RequestTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func acceptRequestButtonPressed(_ sender: UIButton) {
        delegate?.userAcceptedRequest()
    }
    
}
