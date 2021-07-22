//
//  WeatherModel.swift
//  Clima
//
//  Created by abc on 2021/04/02.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation


struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let coordinate: (CLLocationDegrees, CLLocationDegrees)
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
}
