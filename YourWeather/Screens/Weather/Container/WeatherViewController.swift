//
//  WeatherViewController.swift
//  YourWeather
//
//  Created by Vika on 01.05.2024.
//

import UIKit

class WeatherViewController: UIViewController {
    @IBOutlet var weatherInfoHeaderViewController: WeatherInfoHeaderViewController!
    @IBOutlet var todayWeatherSectionViewController: TodayWeatherSectionViewController!
    @IBOutlet var dayForecastSectionViewController: DayForecastSectionViewController!
    
    private let weatherInfoService: WeatherInfoService
    
    init(weatherInfoService: WeatherInfoService) {
        self.weatherInfoService = weatherInfoService
        super.init(nibName: "WeatherViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadWeatherData()
    }

    private func loadWeatherData() {
        weatherInfoService.loadData(for: "Budapest") { [weak self] result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self?.updateUI(weather: weather)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func updateUI(weather: Weather) {
        weatherInfoHeaderViewController.updateView(weather: weather)
        todayWeatherSectionViewController.updateView(weather: weather)
        dayForecastSectionViewController.updateView(weather: weather)
    }
}

