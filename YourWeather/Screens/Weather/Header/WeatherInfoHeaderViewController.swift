//
//  WeatherInfoHeaderViewController.swift
//  YourWeather
//
//  Created by Vika on 09.05.2024.
//

import UIKit

class WeatherInfoHeaderViewController: NSObject {
    @IBOutlet var headerView: WeatherInfoSectionView!
    
    func updateView(weather: Weather) {
        guard let forecast = weather.forecasts.first else { return }
    
        let temperatureCelsius = kelvinToCelsius(kelvin: forecast.temp)
        let maxTemperatureCelsius = kelvinToCelsius(kelvin: forecast.tempMax)
        let minTemperatureCelsius = kelvinToCelsius(kelvin: forecast.tempMin)

        headerView.temperatureLabel.text =  String(format: "%.0f°", temperatureCelsius)
        headerView.cityNameLabel.text = weather.city.uppercased()
        headerView.detailsLabel.text = forecast.description.capitalized
        headerView.maxTemperatureLabel.text = String(format: "H:%.0f°", maxTemperatureCelsius)
        headerView.minTemperatureLabel.text = String(format: "L:%.0f°", minTemperatureCelsius)
    }
    
    private func kelvinToCelsius(kelvin: Double) -> Double {
        return (kelvin - 273.15)
    }
}
