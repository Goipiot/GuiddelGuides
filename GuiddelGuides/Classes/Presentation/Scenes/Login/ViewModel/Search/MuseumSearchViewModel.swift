//
//  MuseumViewModel.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//
import CoreLocation

struct MuseumSearchViewModel {
    
    var museum: Museum?
    var name: String = "N/A"
    var distanceString: String = "N/A"
    var distance: Double!
    
    init?(_ museum: Museum) throws {
        self.museum = museum
        let coordinates = museum.coordinates!
        LocationHelper.shared.getDistance(from: coordinates) { err, distance in
            if let distance = distance, err == nil {
                self.distance = distance
                self.distanceString = String(format: "%.01f км", distance)
            } else if let error = err {
                print(error.localizedDescription)
            }
        }
        name = museum.name!
    }
}
