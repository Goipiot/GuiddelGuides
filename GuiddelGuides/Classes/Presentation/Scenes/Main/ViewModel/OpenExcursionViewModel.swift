//
//  OpenExcursionViewModel.swift
//  GuiddelGuides
//
//  Created by Anton Danilov on 20.08.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import Foundation

struct OpenExcursionViewModel {
    var excursionName: String = "N/A"
    var museumName: String = "N/A"
    var size: String = "N/A"
    var time: String = "N/A"
    var price: String = "N/A"
    var imageURL: String = "N/A"
    var excursion: Excursion!
    
    init(excursion: Excursion) {
        self.excursion = excursion
        excursionName = excursion.title
        museumName = excursion.museum.name
//        let size = excursion.groupLimit - excursion.participants.count
        self.size = "\(excursion.participants.count)/\(excursion.groupLimit) участников"
        price = "\(excursion.price)руб"
        let formatter = DateFormatter.get(with: .fullWithTime)
        if let time = formatter.date(from: excursion.date) {
            self.time = DateFormatter
                .get(with: .timeOnly)
                .string(from: time)
        }
        imageURL = excursion.imageURL
    }
    
}
