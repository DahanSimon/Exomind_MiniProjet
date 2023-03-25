//
//  WeatherViewModel.swift
//  Exomind_MiniProjet
//
//  Created by Simon Dahan on 21/03/2023.
//

import Foundation

class WeatherViewModel {
    private let weatherService = WeatherService()
    private let cities: [String]
    private(set) var weatherData: [CityWeather] = []
    var errorDescription: String? = nil
    
    var onUpdate: (() -> Void)?
    
    init(cities: [String] = ["Rennes", "Paris", "Nantes", "Bordeaux", "Lyon"]) {
        self.cities = cities
    }
    
    func fetchWeatherData() {
        for (index, city) in cities.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index * 10)) {
                if self.errorDescription == nil {
                    self.weatherService.fetchWeatherData(for: city) { [weak self] result in
                        switch result {
                        case .success(let weather):
                            self?.weatherData.append(weather)
                            self?.onUpdate?()
                        case .failure(let error):
                            self?.errorDescription = "Error fetching weather data for \(city): \(error.localizedDescription)"
                            self?.onUpdate?()
                            break
                        }
                    }
                }
            }
        }
    }
    
    func reset() {
        weatherData = []
        errorDescription = nil
    }
}