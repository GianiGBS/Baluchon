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
