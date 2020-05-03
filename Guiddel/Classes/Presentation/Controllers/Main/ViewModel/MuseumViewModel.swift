//
//  MuseumViewModel.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//
import Foundation
import CoreLocation

struct MuseumViewModel {
    
    var name: String = "N/A"
    var distanceString: String = "N/A"
    var distance: Double = 100.0
    
    init?(_ museum: General) throws {
        let coordinates = museum.address.mapPosition.coordinates
        let location = CLLocation(latitude: coordinates[1], longitude: coordinates[0])
        LocationHelper.shared.getDistance(from: location) { err, distance in
            if let distance = distance, err == nil {
                self.distance = distance
                self.distanceString = String(format: "%.01f км", distance)
            } else if let error = err {
                print(error.localizedDescription)
            }
        }
        let fullName = museum.organization.name
        name = NameHelper.shared.getName(from: fullName)
    }
}
