//
//  ExcursionParticipantsTableViewCell.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 22.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import UIKit

class ExcursionParticipantsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var guideImage: RoundCornersImage!
    @IBOutlet weak var guideName: UILabel!
    
    var item: User? {
        didSet {
            guard let item = item else { return }
            guideName.text = item.displayName ?? "N/A"
            guideImage.image = #imageLiteral(resourceName: "like")
            print(item.photoURL)
            guard let imageURL = item.photoURL else { return }
            self.loadImage(from: imageURL) { err, photo in
                if err != nil {
                    if let photo = photo {
                        DispatchQueue.main.async {
                            self.guideImage.image = photo
                        }
                    }
                } else {
                    print(err)
                }
            }
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
}

// MARK: - Image Loading
extension ExcursionParticipantsTableViewCell {
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
