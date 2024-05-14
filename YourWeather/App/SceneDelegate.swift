//
//  SceneDelegate.swift
//  YourWeather
//
//  Created by Vika on 01.05.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)

        window.rootViewController = makeWeatherViewController()
        self.window = window
        window.makeKeyAndVisible()
    
    }
    
    func makeWeatherViewController() -> WeatherViewController {
        let remoteWeatherService = RemoteWeatherService()
        let localWeatherService = CoreDataService()
        let weatherService = WeatherCompositeService(
            remoteWeatherService: remoteWeatherService,
            localWeatherService: localWeatherService
        )
        let vc = WeatherViewController(weatherInfoService: weatherService)
        return vc
    }
    
}

