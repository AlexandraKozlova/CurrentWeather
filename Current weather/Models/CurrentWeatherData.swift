//
//  CurrentWeatherData.swift
//  Current weather
//
//  Created by Aleksandra on 10.03.2022.
//

import Foundation

struct CurrentWeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let wind: Wind
}

struct Main: Codable {
    let temp: Double
    let feelsLike: Double
    let pressure: Int
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
            case temp
            case feelsLike = "feels_like"
            case pressure
            case humidity
    }
}

struct Weather: Codable {
    let id: Int
    let weatherDescription: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case weatherDescription = "description"
    }
}
    
struct Wind: Codable {
    let speed: Double
}

