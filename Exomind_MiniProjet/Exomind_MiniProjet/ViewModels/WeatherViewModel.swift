//
//  WeatherViewModel.swift
//  Exomind_MiniProjet
//
//  Created by Simon Dahan on 21/03/2023.
//

import Foundation

//TODO: Test
class WeatherViewModel {
    private let weatherService = WeatherService()
    let cities: [String]
    private(set) var weatherData: [CityWeather] = []
    var errorDescription: String = ""
    var apiCallsCount: Int = 0
    private var messageIndex = 0
    private let messages: [String]
    
    
    var onUpdate: (() -> Void)?
    var updateMessage: ((String) -> Void)?
    
    init(cities: [String] = ["Rennes", "Paris", "Nantes", "Bordeaux", "Lyon"],
         messages: [String] = [
            "Nous téléchargeons les données…",
            "C’est presque fini…",
            "Plus que quelques secondes avant d’avoir le résultat…"]) {
                self.cities = cities
                self.messages = messages
            }
    
    func fetchWeatherData() {
        for (index, city) in cities.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index * 10)) {
                self.weatherService.fetchWeatherData(for: city) { [weak self] result in
                    switch result {
                    case .success(let weather):
                        self?.weatherData.append(weather)
                        self?.onUpdate?()
                    case .failure(let error):
                        self?.errorDescription += "Error fetching weather data for \(city): \(error.localizedDescription)\n"
                        self?.onUpdate?()
                    }
                    self?.apiCallsCount += 1
                }
            }
        }
    }
    
    func reset() {
        weatherData = []
        apiCallsCount = 0
        errorDescription = ""
    }
    
    func startMessageRotation() {
        updateMessage?(messages[messageIndex])
        Timer.scheduledTimer(withTimeInterval: 6, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.messageIndex = (self.messageIndex + 1) % self.messages.count
            self.updateMessage?(self.messages[self.messageIndex])
        }
    }
}
