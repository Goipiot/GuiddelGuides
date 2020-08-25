//
//  ExcursionRequestManager.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 17.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation
import FirebaseStorage
import Firebase

class ExcursionRequestManager {
    
    static let shared = ExcursionRequestManager()
    
    static func updateExcursionInfo(excursion: Excursion, image: UIImage, completion: @escaping(Error?) -> Void) {
        StorageManager.shared.uploadExcursionImage(image: image, label: excursion.title) { imageURL, error in
            if let imageURL = imageURL, error == nil {
                var finalExcursion = excursion
                finalExcursion.imageURL = imageURL
                ExcursionFirestoreManager.shared.send(object: finalExcursion) { err in
                    if err != nil {
                        completion(err)
                    }
                }
                completion(nil)
            } else {
                completion(error)
            }
        }
    }
    
//    
//    // Private init
//    private init() { }
    
}
