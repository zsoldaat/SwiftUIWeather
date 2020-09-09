//
//  WeatherModel.swift
//  SwiftUIWeatherApp
//
//  Created by Zac Soldaat on 2020-09-09.
//  Copyright © 2020 Zac Soldaat. All rights reserved.
//

import Foundation

class WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [WeatherArray]
}

class Main: Decodable {
    let temp: Double
}

class WeatherArray: Decodable {
    let id: Int
    let description: String
}
