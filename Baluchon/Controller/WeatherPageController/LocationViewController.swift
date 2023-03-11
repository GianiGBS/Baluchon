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
        guard let data = weatherLocationManager.data, !data.sys.country.isEmpty else {
            return self.presentAlert(title: "Erreur", message: "Aucune données.")

        }
        temperature.text = "\(data.main.temp)°"
        mainWeather.text = "\(data.weather[0].main)"
        cityAndCountry.text = "\(data.name), \(data.sys.country)"
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
