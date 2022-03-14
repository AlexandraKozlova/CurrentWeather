//
//  CurrentWeather.swift
//  Current weather
//
//  Created by Aleksandra on 09.03.2022.
//

import Foundation

struct CurrentWeather {
    
    let cityName: String
    let conditionCode: Int
    let temperature: Double
    let feelsLikeTemperature: Double
    let weatherDescription: String
    let pressure: Int
    let humidity: Int
    let windSpeed: Double
    
    var temperatureString: String { return String(format: "%.0f C°", temperature) }
    var feelsLikeTemperatureString: String { return String(format: "Feels like %.0f C°", feelsLikeTemperature) }
    var pressureString: String { return ("Pressure: \(pressure)hPa") }
    var humidityString: String { return ("Humidity: \(humidity)%") }
    var windSpeedString: String { return ("Wind Speed: \(windSpeed)m/s") }
    
    var systemNameIconWeather: String {
        switch conditionCode {
        case 200...232:
            return "thunderstorm"
        case 300...321:
            return "drizzle"
        case 500...531:
            return "drizzle"
        case 600...622:
            return "snow"
        case 700...781:
            return "fog"
        case 800:
            return "sun"
        case 801...804:
            return "cloud"
        default:
            return "icloud.slash"
        }
    }
    
    init?(currentWeatherData: CurrentWeatherData) {
        cityName = currentWeatherData.name
        conditionCode = currentWeatherData.weather.first!.id
        temperature = currentWeatherData.main.temp
        feelsLikeTemperature = currentWeatherData.main.feelsLike
        weatherDescription = currentWeatherData.weather.first!.weatherDescription
        pressure = currentWeatherData.main.pressure
        humidity = currentWeatherData.main.humidity
        windSpeed = currentWeatherData.wind.speed
    }
}
