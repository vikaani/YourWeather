//
//  WeatherInfoService.swift
//  YourWeather
//
//  Created by Vika on 07.05.2024.
//

import Foundation

protocol WeatherInfoService {
    func loadData(for city: String, completionHandler: @escaping (Result<Weather,Error>) -> Void)
}




    
    

