//
//  UserLocationPresenter.swift
//  NewsAppKarSpv
//
//  Created by Karolis on 2021-05-27.
//

import Foundation
import CoreLocation
import MapKit

class UserLocationPresenter: NSObject, CLLocationManagerDelegate {
    
    // MARK: - Declarations
    var locationManager = CLLocationManager()

    var didUpdateLocation: (_ location: CLLocation) -> Void
    var didAuthorizeLocation: () -> Void
    
    // MARK: - Methods
    init(didUpdateLocation: @escaping (_ location: CLLocation) -> Void,
         didAuthorizeLocation: @escaping () -> Void) {
        self.didUpdateLocation = didUpdateLocation
        self.didAuthorizeLocation = didAuthorizeLocation
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocation = locations.first else {
            return
        }
        didUpdateLocation(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
            didAuthorizeLocation()
        } else {
            locationManager.stopUpdatingLocation()
        }
    }
    
    // MARK: - Locating
    func startLocatingIfAuthorized() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        }
    }
    
    // MARK: - Authorization
    private func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            
        case .denied, .restricted:
            locationManager.stopUpdatingLocation()
            
        @unknown default:
            break
        }
    }
}
