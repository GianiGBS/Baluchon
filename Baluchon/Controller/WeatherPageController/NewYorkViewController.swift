//
//  NewYorkViewController.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 07/02/2023.
//

import UIKit

class NewYorkViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet var viewBackground: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var mainWeather: UILabel!
    @IBOutlet weak var cityAndCountry: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Properties
    let weatherNewYorkManager = WeatherManager()
    var currentLocationNewYork = CurrentLocation()

    // MARK: - Navigation
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherNewYorkManager.delegate = self
        currentLocationNewYork.setCurrentLocation(townLocator: .newYork)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        currentLocationNewYork.setCurrentLocation(townLocator: .newYork)
    }
    // MARK: - Actions
    @IBAction func refresh(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        weatherNewYorkManager.getData()
    }
    // MARK: - Methods
}
// MARK: - Delegate Pattern
extension NewYorkViewController: ViewDelegate {
    func updateView() {
        toggleActivityIndicator(shown: false)
        guard let data = weatherNewYorkManager.data, !data.base.isEmpty else {
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
