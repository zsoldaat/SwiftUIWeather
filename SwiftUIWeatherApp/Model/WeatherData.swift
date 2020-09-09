//
//  WeatherData.swift
//  SwiftUIWeatherApp
//
//  Created by Zac Soldaat on 2020-09-09.
//  Copyright © 2020 Zac Soldaat. All rights reserved.
//

import Foundation

struct WeatherModel {
    
    let cityName: String
    let temperature: Double
    let condition: Int
    
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    
    var conditionString: String {
        let firstDigit = condition/100
        
        if condition == 800 {
            return "sun.max"
        } else {
        
            switch firstDigit {
                
            case 1:
                return "cloud.bolt"
            case 3:
                return "cloud.drizzle"
            case 5:
                return "cloud.rain"
            case 6:
                return "cloud.snow"
            case 7:
                return "cloud.fog"
            case 8:
                return "cloud"
                
            default:
                return "weather condition ID not handled"
            }
        }
    }
    
}
