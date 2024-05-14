//
//  Weather.swift
//  YourWeather
//
//  Created by Vika on 09.05.2024.
//

import Foundation

struct Weather {
    let city: String
    let forecasts: [Forecast]
}

struct Forecast {
    let date: Date
    let temp: Double
    let tempMin: Double
    let tempMax: Double
    let description: String
}


