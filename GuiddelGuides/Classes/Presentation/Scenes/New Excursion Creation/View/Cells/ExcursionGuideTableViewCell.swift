//
//  ExcursionGuideTableViewCell.swift
//  Guiddel
//
//  Created by Anton Danilov on 13.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class ExcursionGuideTableViewCell: UITableViewCell {
    
    @IBOutlet weak var guideImage: RoundCornersImage!
    @IBOutlet weak var guideName: UILabel!
    
    var item: ExcursionViewModelItem? {
        didSet {
            guard let item = item as? ExcursionViewModelGuideItem else { return }
            guideName.text = item.guideName
            guideImage.image = nil
            self.loadImage(from: item.pictureUrl) { err, photo in
                if err != nil {
                } else {
                    if let photo = photo {
                        DispatchQueue.main.async {
                            self.guideImage.image = photo
                        }
                    }
                }
            }
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

// MARK: - Image Loading
extension ExcursionGuideTableViewCell {
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
