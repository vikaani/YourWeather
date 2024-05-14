//
//  LocalWeatherService.swift
//  YourWeather
//
//  Created by Vika on 09.05.2024.
//

import Foundation

protocol LocalWeatherService {
    func loadData(for city: String, completionHandler: @escaping (Result<Weather, Error>) -> Void)
    func save(weather: Weather) throws
}
