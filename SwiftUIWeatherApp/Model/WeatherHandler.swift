//
//  WeatherHandler.swift
//  SwiftUIWeatherApp
//
//  Created by Zac Soldaat on 2020-09-09.
//  Copyright © 2020 Zac Soldaat. All rights reserved.
//

import Foundation

struct WeatherHandler {
    
    var APIString = "https://api.openweathermap.org/data/2.5/weather?appid=a6c01bddd788368cb20d8a1d048d979a"
    
    var city: String = "" {
        didSet {
            APIString = APIString + "&q=\(city)"
        }
    }
    
    var longitude: Double = 0 {
        didSet {
            APIString = APIString + "&lat=\(longitude)" + "&lon=\(latitude)"
        }
    }
    
    var latitude: Double = 0 {
        didSet {
            APIString = APIString + "&lat=\(longitude)" + "&lon=\(latitude)"
        }
    }
    
    
    func fetchWeather(units: String, completion: @escaping (WeatherModel?) -> ()) {
        
        var APIString = self.APIString.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        
        APIString = APIString + "&units=\(units)"
        
        guard let url = URL(string: APIString) else {
            fatalError("Invalid URL")
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data,response,error in
            if let error = error {
                // handle the transport error
                print("Task Error:\(error.localizedDescription)")
                completion(nil)
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                // handle the server error
                print("Server error:")
                completion(nil)
                return
            }
            
            if let safeData = data {
                if let decoded = try? JSONDecoder().decode(WeatherData.self, from: safeData) {
                    let cityName = decoded.name
                    let temperature = decoded.main.temp
                    let condition = decoded.weather[0].id
                    let weatherModel = WeatherModel(cityName: cityName, temperature: temperature, condition: condition)
                    completion(weatherModel)
                }
            }
        })
        task.resume()
    }
    
}
