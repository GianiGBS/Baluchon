//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 06/11/2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    // MARK: - Properties
    
    // CLLocationManager
    let manager = CLLocationManager()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Localisation
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let longitude = location.coordinate.longitude
        let latitude = location.coordinate.latitude
        print(latitude)
        print(longitude)
    }
    

    

}
