//
//  WeatherData.swift
//  Clima
//
//  Created by abc on 2021/04/02.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: Coord
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}

struct Coord: Codable {
    let lon: CLLocationDegrees
    let lat: CLLocationDegrees
}
