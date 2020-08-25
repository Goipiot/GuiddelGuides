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
//        locationManager.pausesLocationUpdatesAutomatically = false
//        locationManager.startUpdatingLocation()
//        locationManager.startMonitoringSignificantLocationChanges()
    }

    func getLocation() -> CLLocation? {
        return locationManager.location
    }
    
    func getDistance(from location: CLLocation, completion: ((NSError?, Double?) -> Void)) {
        guard let yourLocation = locationManager.location else {
            return completion(NSError(), nil)
        }
        let distance = yourLocation.distance(from: location)/1000
        return completion(nil, distance)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
}
