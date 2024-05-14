//
//  WeatherCompositeService.swift
//  YourWeather
//
//  Created by Vika on 09.05.2024.
//

import Foundation

class WeatherCompositeService: WeatherInfoService {
    private let remoteWeatherService: WeatherInfoService
    private let localWeatherService: LocalWeatherService
    
    init(remoteWeatherService: WeatherInfoService, localWeatherService: LocalWeatherService) {
        self.remoteWeatherService = remoteWeatherService
        self.localWeatherService = localWeatherService
    }
    
    func loadData(for city: String, completionHandler: @escaping (Result<Weather, Error>) -> Void) {
        localWeatherService.loadData(for: city) { [weak self] result in
            switch result {
            case .success(let weather):
                completionHandler(.success(weather))
            case .failure(_):
                self?.remoteWeatherService.loadData(for: city) { [weak self] result in
                    switch result {
                    case .success(let weather):
                       try? self?.localWeatherService.save(weather: weather)
                       completionHandler(.success(weather))
                    case .failure(let failure):
                        completionHandler(.failure(failure))
                    }
                }
            }
        }
    }
}
