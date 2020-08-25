//
//  OpenExcursionTableViewCell.swift
//  Guiddel
//
//  Created by Anton Danilov on 08.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class OpenExcursionTableViewCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var excursionImageView: RoundCornersImage!
    @IBOutlet weak var excursionLabel: UILabel!
    @IBOutlet weak var excursionDateLabel: UILabel!
    @IBOutlet weak var museumNameLabel: UILabel!
    @IBOutlet weak var excursionPriceLabel: UILabel!
    @IBOutlet weak var excursionSizeLabel: UILabel!
    
    
    public func setData(excursionVM: OpenExcursionViewModel) {
        excursionLabel.text = excursionVM.excursionName
        excursionSizeLabel.text = excursionVM.size
        museumNameLabel.text = excursionVM.museumName
        excursionDateLabel.text = excursionVM.time
        excursionImageView.image = #imageLiteral(resourceName: "british-museum-london-exterior")
        excursionPriceLabel.text = excursionVM.price
        self.loadImage(from: excursionVM.imageURL) { err, photo in
            if err != nil {
            } else {
                if let photo = photo {
                    DispatchQueue.main.async {
                        self.excursionImageView.image = photo
                    }
                }
            }
        }
        
    }
    
}

// MARK: - Image Loading
extension OpenExcursionTableViewCell {
    func loadImage(from photoURLString: String?, completion: @escaping (Error?, UIImage?) -> Void) {
        guard let string = photoURLString else {
            completion(BaseError.invalidData, nil)
            return
        }
        let createdUrl = URL(string: string)
        guard let url = createdUrl else {
            completion(BaseError.invalidData, nil)
            return
            
        }
        self.getData(from: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(error, nil)
                return
            }
            let image = UIImage(data: data)
            completion(nil, image)
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
