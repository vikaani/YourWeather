//
//  NetworkService.swift
//  YourWeather
//
//  Created by Vika on 09.05.2024.
//

import Foundation

class NetworkService {
    static func load<T: Codable>(url: URL, completionHandler: @escaping (Result<T,Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession(configuration: .ephemeral).dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            guard let responseData = data else { return }
            
            do {
                let weather = try JSONDecoder().decode(T.self, from: responseData)
                completionHandler(.success(weather))
            } catch {
                debugPrint(error.localizedDescription)
            }
        }.resume()
    }
}
