//
//  LocationHandler.swift
//  UberClone
//
//  Created by VITALIY SVIRIDOV on 12.08.2021.
//

import Foundation
import CoreLocation

class LocationHandler: NSObject {
    
    static let shared = LocationHandler()
    
    var locationManager: CLLocationManager!
    var location: CLLocation?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManagerDidChangeAuthorization(locationManager)
    }
    
    
}

extension LocationHandler: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        
        case .notDetermined:
            print("notDetermined")
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted, .denied: print("restricted")
            
        case .authorizedAlways:
            print("authorizedAlways")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            locationManager.requestAlwaysAuthorization()
            
        @unknown default:
            print("unknown default")
        }
        
        if manager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
}
