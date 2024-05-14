//
//  TodayWeatherSectionViewController.swift
//  YourWeather
//
//  Created by Vika on 09.05.2024.
//

import UIKit

class TodayWeatherSectionViewController: NSObject {
    @IBOutlet var todayView: TodayWeatherSectionView!
    
    var forecasts: [Forecast] = []
    
    func updateView(weather: Weather) {
        forecasts = weather.forecasts

//        let hour = Calendar.current.component(.hour, from: forecast.date)
//        let weakday = Calendar.current.component(.weekday, from: forecast.date)
    }

}
