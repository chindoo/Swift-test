//
//  GeolocationManager.swift
//  PublicToilets
//
//  Created by Chedli Lakhdhar on 03/07/2022.
//

import Foundation
import CoreLocation

class GeolocationManager: NSObject {
    
    // MARK: Properties
    
    private let locationManager = CLLocationManager()
    private var permissionCompletion: ((Bool) -> Void)?
    private var locationCompletion: ((CLLocation?) -> Void)?
    static var shared = GeolocationManager()
    
    // MARK: Init
    
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.delegate = self
    }
    
    // MARK: LocationProviderProtocol
    
    var isLocationAvailable: Bool {
        guard CLLocationManager.locationServicesEnabled() else {
            return false
        }
        
        switch locationManager.authorizationStatus {
        case .authorizedAlways,
             .authorizedWhenInUse:
            return true
            
        default:
            return false
        }
    }
    
    var isPermissionNotDetermined: Bool {
        locationManager.authorizationStatus == .notDetermined
    }
    
    var lastLocation: CLLocation? {
        locationManager.location
    }
    
    func requestPermission(permissionCompletion: @escaping (Bool) -> Void) {
        guard CLLocationManager.locationServicesEnabled() else {
            self.permissionCompletion = permissionCompletion
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .authorizedAlways, .authorizedWhenInUse:
            permissionCompletion(true)
            
        default:
            permissionCompletion(false)
        }
    }
    
    func updateLocation() {
        guard CLLocationManager.locationServicesEnabled() else {
            locationCompletion?(nil)
            return
        }
        
        if let location = locationManager.location,
            location.timestamp.timeIntervalSinceNow < 2000.0 {
            locationCompletion?(location)
            return
        }
        
        locationManager.requestLocation()
    }
    
    func updateLocation(locationCompletion: @escaping (CLLocation?) -> Void) {
        guard CLLocationManager.locationServicesEnabled() else {
            locationCompletion(nil)
            return
        }

        self.locationCompletion = locationCompletion
        
        if let location = locationManager.location,
            location.timestamp.timeIntervalSinceNow < 2000.0 {
            locationCompletion(location)
            return
        }

        locationManager.requestLocation()
    }
}

extension GeolocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways,
             .authorizedWhenInUse:
            permissionCompletion?(true)
            
        default:
            permissionCompletion?(true)
        }
        
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        locationCompletion?(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationCompletion?(nil)
    }
}
