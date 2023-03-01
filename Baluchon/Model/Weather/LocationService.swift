//
//  Geolocation.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 01/03/2023.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {

    // MARK: - Properties
    let location = CLLocationManager()
    var currentlocation: CLLocation?
    let weatherManager = WeatherManager()

    // MARK: - Initialization

    // MARK: - Methods
    func getLocation() {
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyKilometer
        location.requestWhenInUseAuthorization()
        location.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentlocation = location
            print(location)
            let latitude: Double = self.currentlocation!.coordinate.latitude
            let longitude: Double = self.currentlocation!.coordinate.longitude

            print(latitude)
            print(longitude)
            
            weatherManager.getData()
        }
    }
}
