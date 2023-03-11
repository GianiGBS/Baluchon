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
    static var shared = LocationService()
    let location = CLLocationManager()
    var currentlocation: CLLocation?
    let weatherManager = WeatherManager()
    var latitude = ""
    var longitude = ""

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
            latitude = "\(self.currentlocation!.coordinate.latitude)"
            longitude = "\(self.currentlocation!.coordinate.longitude)"
            CurrentLocation.latitude = latitude
            CurrentLocation.longitude = longitude
        }
    }
}
