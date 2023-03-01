//
//  Geolocation.swift
//  Baluchon
//
//  Created by Giovanni Gabriel on 10/02/2023.
//

import Foundation
struct Currentlocation {

    static var latitude = "48.85679"
    static var longitude = "2.35108"
}

func setLatitude(lat: Double) {
        Currentlocation.latitude =  String(lat)
    }
func setLongitude(lon: Double) {
        Currentlocation.longitude = String(lon)
    }

// switch townLocator {
// case .paris:
//    Geolocation.latitude = "48.85679"
//    Geolocation.longitude = "2.35108"
// case .newYork:
//    Geolocation.latitude = "48.85679"
//    Geolocation.longitude = "2.35108"
// default:
//    <#code#>
// }
