//
//  WeatherVM.swift
//  SwiftUIWeatherApp
//
//  Created by Zac Soldaat on 2020-09-09.
//  Copyright © 2020 Zac Soldaat. All rights reserved.
//

import Foundation

class WeatherVM: ObservableObject {
    
    var weatherHandler = WeatherHandler()
    
    @Published var searchText: String = ""
    
    @Published var cityName: String = ""
    @Published var temperature: String = ""
    @Published var unitsInMetric: Bool = true
    @Published var conditionString: String = "cloud"

    
    func fetchWeather(location: Bool? = nil) {
        if location != nil {
            if location == true {
                let locationDataManager = LocationDataManager()
                
                weatherHandler.latitude = locationDataManager.userLatitude
                weatherHandler.longitude = locationDataManager.userLongitude
            } else {
                weatherHandler.city = searchText
            }
        }

        weatherHandler.fetchWeather(units: unitsInMetric ? "metric" : "imperial") { model in
            if model != nil {
                DispatchQueue.main.async {
                    self.cityName = model!.cityName
                    self.temperature = model!.temperatureString
                    self.conditionString = model!.conditionString
                }
                
            }
        }
    }

}
