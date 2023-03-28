//
//  LocationViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 10/02/2023.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var viewBackground: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var mainWeather: UILabel!
    @IBOutlet weak var cityAndCountry: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Properties
    let weatherLocationManager = WeatherManager()
    var currentLocation = CurrentLocation()

    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherLocationManager.delegate = self
        currentLocation.setCurrentLocation(townLocator: .townlocation)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    // MARK: - Actions
    @IBAction func refresh(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        weatherLocationManager.getData()
    }
    // MARK: - Methods
}
// MARK: - Delegate Pattern
extension LocationViewController: ViewDelegate {
    func updateView() {
        toggleActivityIndicator(shown: false)
        guard let data = weatherLocationManager.data, !data.base.isEmpty else {
            return self.presentAlert(title: "Erreur", message: "Aucune données.")

        }
        if let temp = data.main.temp {
            temperature.text = "\(Int(round(temp)))°"
        }
        if let main = data.weather[0].main {
            mainWeather.text = "\(main)"
        }
        if let city = data.name, let country = data.sys.country {
            cityAndCountry.text = "\(city), \(country)"
        }
        if let image = data.weather[0].icon {
            self.icon.image = UIImage(systemName: "\(String(describing: icons["\(image)"]!))")
            // self.viewBackground.backgroundColor = color["\(image)"]
        }
    }
    func presentAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alertVC, animated: true, completion: nil)
    }
    internal func toggleActivityIndicator(shown: Bool) {
        refreshButton.isUserInteractionEnabled = !shown
        activityIndicator.isHidden = !shown
    }

}
