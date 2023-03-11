//
//  Geolocation.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 10/02/2023.
//

import Foundation
// MARK: - CurrentLocation
struct CurrentLocation {

    static var latitude = ""
    static var longitude = ""

    func setCurrentLocation(townLocator: TownLocation) {
         switch townLocator {
         case .paris:
             CurrentLocation.latitude = "48.8534"
             CurrentLocation.longitude = "2.3488"
         case .newYork:
             CurrentLocation.latitude = "40.712784"
             CurrentLocation.longitude = "-74.005941"
         case .townlocation:
             LocationService.shared.getLocation()
         }
    }
}
// MARK: - TownLocation
enum TownLocation {
    case paris
    case newYork
    case townlocation
}
