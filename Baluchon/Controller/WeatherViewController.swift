//
//  WeatherViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 06/11/2022.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    let manager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    // Verification de la clé
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_WEATHER_KEY") as? String
        guard let key = apiKey, !key.isEmpty else {
            print("API key does not exist")
            return
        }
        print("REST API key:", key)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
