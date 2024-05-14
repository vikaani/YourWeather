//
//  APIConstant.swift
//  YourWeather
//
//  Created by Vika on 10.05.2024.
//

import Foundation

struct APIConstant {
    
    static let baseURL = "https://api.openweathermap.org"
    static let dataPath = "/data"
    static let apiVersion = "2.5"
    static let forecastPath = "/forecast"
    
    static let apiKey = "20f6e8143f61cf1dd94c328295361cd2"
    
    static func weatherURL() -> String {
        return baseURL + dataPath + "/" + apiVersion + forecastPath
    }
}
