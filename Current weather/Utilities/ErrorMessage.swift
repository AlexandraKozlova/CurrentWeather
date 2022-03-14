//
//  ErrorMessage.swift
//  Current weather
//
//  Created by Aleksandra on 11.03.2022.
//

import Foundation

enum CWError: String, Error {
    case ivalidCityName = "Unfortunately we did not find this city. Please try again."
    case unableToComplite = "Unable to complited your request. Please check your internet connection."
    case invalidResponse = "Invalid response from server. Please, try again."
    case invalidData = "The data received from server was invalid. Please try again."
}
