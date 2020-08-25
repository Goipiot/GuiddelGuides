//
//  ExcursionBuilder.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 14.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation
import UIKit

class ExcursionBuilder {
    
    private init() {}
    
    static let shared = ExcursionBuilder()
    
    private var excursion = Excursion()
    private var photo = UIImage()
    
    func reset() {
        excursion = Excursion()
        photo = UIImage()
    }
    
    func setTitle(title: String) {
        excursion.title = title
    }
    
    func setGroupSize(size: Int) {
        excursion.groupLimit = size
    }
    
    func setPrice(price: Int) {
        excursion.price = price
    }
    
    func setImage(image: UIImage) {
        photo = image
    }
    
    func setDate(time: String, day: String) {
        excursion.date = time
        excursion.day = day
        
    }
    
    func getImage() -> UIImage {
        return photo
    }
    
    func build() -> Excursion {
        return excursion
    }
}
