//
//  RemoteWeatherService.swift
//  YourWeather
//
//  Created by Vika on 09.05.2024.
//

import UIKit
import CoreLocation

class RemoteWeatherService: WeatherInfoService {
    enum WeatherError: Error {
        case cityNotFound, placemarkNotFound, locationNotFound, invalidData, invalidURL
    }
    
    func loadData(for city: String, completionHandler: @escaping (Result<Weather, Error>) -> Void) {
        getLocation(for: city) { result in
            switch result {
            case .success(let coordinate):
                let lat = coordinate.latitude
                let lon = coordinate.longitude
       
                let urlString = "\(APIConstant.weatherURL())?lat=\(lat)&lon=\(lon)&appid=\(APIConstant.apiKey)"
                
                let url = URL(string: urlString)!
                
                let request = URLRequest(url: url)
                
                URLSession.shared.dataTask(with: request) { data, response, error in
                    guard error == nil else { return }
                    guard let responseData = data else { return }
                    
                    do {
                        let jsonDecoder = JSONDecoder()
                        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                        
                        let response = try jsonDecoder.decode(DecodableWeatherData.self, from: responseData)
                        
                        let forecasts = response.list.map { forecast in
                            Forecast(
                                date: Date(timeIntervalSince1970: forecast.dt),
                                temp: forecast.main.temp,
                                tempMin: forecast.main.tempMin,
                                tempMax: forecast.main.tempMax,
                                description: forecast.weather.first?.description ?? ""
                            )
                        }
                        
                        let weather = Weather(city: response.city.name, forecasts: forecasts)
                        completionHandler(.success(weather))
                        
                    } catch {
                        completionHandler(.failure(WeatherError.invalidData))
                        debugPrint(error.localizedDescription)
                    }
                }.resume()
                
            case .failure(let failure):
                completionHandler(.failure(failure))
            }
        }
        
    }
    
    func getLocation(for city: String, completionHandler: @escaping (Result<CLLocationCoordinate2D ,WeatherError>) -> Void) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(city) { placemarks, error in
            guard error == nil else {
                completionHandler(.failure(.cityNotFound))
                return
            }
            
            guard let placemark = placemarks?.first else {
                completionHandler(.failure(.placemarkNotFound))
                return
            }
            
            guard let location = placemark.location else {
                completionHandler(.failure(.locationNotFound))
                return
            }
            
            let coordinate = location.coordinate
            completionHandler(.success(coordinate))
        }
    }
    
    struct DecodableWeatherData: Decodable {
        let list: [DecodableForecast]
        let city: DecodableCity
    }
    
    struct DecodableForecast: Decodable {
        let dt: Double
        let main:  DecodableMain
        let weather: [DecodableWeather]
    }
    
    struct  DecodableMain: Decodable {
        let temp: Double
        let tempMin: Double
        let tempMax: Double
    }
    
    struct DecodableWeather: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct DecodableCity: Decodable {
        let id: Int
        let name: String
        let coord:  DecodableCoord
        let country: String
    }
    
    struct  DecodableCoord: Decodable {
        let lat: Double
        let lon: Double
    }
}
