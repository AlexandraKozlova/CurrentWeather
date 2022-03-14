//
//  NetworkingManager.swift
//  Current weather
//
//  Created by Aleksandra on 09.03.2022.
//

import UIKit

class NetworkingManager {
    
    func fetchCurrentWeather(forCity city: String, complited: @escaping (Result <CurrentWeather, CWError>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Constants.keyAPI)&units=metric"
        
        guard let url = URL(string: urlString) else {
            complited(.failure(.ivalidCityName))
            return
        }
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                complited(.failure(.unableToComplite))
            }
            
            guard let response = response as? HTTPURLResponse else {
                complited(.failure(.invalidResponse))
                return
            }
            
            if response.statusCode == 404 {
                complited(.failure(.ivalidCityName))
                return
            }
            
            guard response.statusCode == 200 else {
                complited(.failure(.invalidResponse))
                return
            }
            
            
            if let data = data {
                if let currentWeather = self.parceJSON(withData: data) {
                    
                    complited(.success(currentWeather))
                } else {
                    complited(.failure(.invalidData))
                }
            }
        }
        task.resume()
    }
    
    func parceJSON(withData data: Data) -> CurrentWeather? {
        let decoder = JSONDecoder()
        
        do {
            let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
            guard let currentWeather = CurrentWeather(currentWeatherData: currentWeatherData) else { return nil }
                    return currentWeather
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
