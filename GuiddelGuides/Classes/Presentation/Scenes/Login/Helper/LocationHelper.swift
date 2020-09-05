//
//  LocationHelper.swift
//  Guiddel
//
//  Created by Anton Danilov on 01.05.2020.
//  Copyright © 2020 Anton Danilov. All rights reserved.
//

import CoreLocation

final class LocationHelper: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationHelper()
    
    private let locationManager = CLLocationManager()

    override init() {
        super.init()

        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
//        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = true
//        locationManager.startUpdatingLocation()
//        locationManager.startMonitoringSignificantLocationChanges()
    }

    func getLocation() -> CLLocation? {
        return locationManager.location
    }
    
    func getDistance(from coordinates: [Double], completion: ((Error?, Double?) -> Void)) {
        let location = CLLocation(latitude: coordinates[1], longitude: coordinates[0])
        guard let yourLocation = locationManager.location else {
            return completion(BaseError.invalidData, nil)
        }
        let distance = yourLocation.distance(from: location) / 1000
        return completion(nil, distance)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
}
