//
//  LocationViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 10/02/2023.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {

    // MARK: - Outlets
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var mainWeather: UILabel!
    @IBOutlet weak var city: UILabel!

    // MARK: - Properties
    // Location Manager
    let locationManaging = CLLocationManager()
    var currentlocation: CLLocation?
    let weatherManager = WeatherManager()

    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        // getLocation()
        weatherManager.delegate = self
    }

    // MARK: - Methods

}

// MARK: - Delegate Pattern
extension LocationViewController: ViewDelegate {
    func updateView() {
        guard let data = weatherManager.data, !data.weather.isEmpty else {
            return self.presentAlert(title: "Erreur", message: "Aucune données.")

        }
        temperature.text = "\(data.main.temp)"
        mainWeather.text = "\(data.weather[0].main)"
        city.text = "\(data.name), \(data.sys.country)"

    }
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
    }

}
