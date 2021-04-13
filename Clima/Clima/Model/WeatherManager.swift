//
//  WeatherManager.swift
//  Clima
//
//  Created by abc on 2021/04/02.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManger, weather: WeatherModel)
    func didFailWithError(error: Error)
    
}

struct WeatherManger{
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=913b5dbe414db8b6761e55fdecc3d827&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        //1. Create URL
        if let url = URL(string: urlString){
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    self.delegate?.didFailWithError(error: error)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(weatherData: safeData) {
                        self.delegate?.didUpdateWeather(self, weather: weather)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
         let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            let coordinate = (decodeData.coord.lat, decodeData.coord.lon)
            
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, coordinate: (coordinate.0, coordinate.1))
            return weather
        } catch{
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
