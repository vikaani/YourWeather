//
//  CoreDataService+LocalWeatherService.swift
//  YourWeather
//
//  Created by Vika on 09.05.2024.
//

import Foundation

extension CoreDataService: LocalWeatherService {
    
    fileprivate enum WeatherServiceError: Error {
        case dataNotExist
    }
    
    func loadData(for city: String, completionHandler: @escaping (Result<Weather, Error>) -> Void) {
        completionHandler(.failure(WeatherServiceError.dataNotExist))
    }
    
    func save(weather: Weather) throws {
        
    }
}
