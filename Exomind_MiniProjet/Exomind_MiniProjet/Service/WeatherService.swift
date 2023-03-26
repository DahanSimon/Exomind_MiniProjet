import Foundation

//TODO: Mock for testing
struct WeatherService {
    //TODO: Save API key in .plist file
    let apiKey = "be119e6e4c0a0f05303ec9a30132499e"
    
    func fetchWeatherData(for city: String, completion: @escaping (Result<CityWeather, Error>) -> Void) {
        guard let url = createURL(for: city) else {
            completion(.failure(NSError(domain: "Unable to generate URL", code: 400, userInfo: nil)))
            return
        }
        
        let request = createRequest(for: url)
        getWeatherData(for: request, city: city) { result in
            completion(result)
        }
    }
}

private extension WeatherService {
    func createURL(for city: String) -> URL? {
        guard let cityNameUrlFriendly = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return nil
        }
        let query = "https://api.openweathermap.org/data/2.5/weather?q=\(cityNameUrlFriendly)&appid=\(apiKey)&units=metric&lang=fr"
        return URL(string: query)
    }
    
    func createRequest(for url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
    
    func getWeatherData(for request: URLRequest, city: String, completion: @escaping (Result<CityWeather, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 204, userInfo: nil)))
                return
            }
            
            do {
                let weather = try JSONDecoder().decode(CityWeather.self, from: data)
                completion(.success(weather))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
