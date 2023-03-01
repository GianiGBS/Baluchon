//
//  WeatherManager.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 28/02/2023.
//

import Foundation

// MARK: - Weather Location
class WeatherManager {

    // MARK: Properties
    var data: Ephemeride?
    let weatherService = WeatherService.shared
    public weak var delegate: ViewDelegate?

    // MARK: Methods
    public func getData() {
        weatherService.getWeather { success, ephemeride in
            guard let ephemeride = ephemeride, success == true else {
                        self.delegate?.presentAlert(title: "Echec de l'appel",
                                                    message: "Google n'a pas répondu.\nVeuillez réessayer.")
                        return
                    }
            self.data = ephemeride
            self.delegate?.updateView()
        }
    }
}
