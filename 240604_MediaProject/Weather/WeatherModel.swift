//
//  WeatherModel.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/8/24.
//

import Foundation

// MARK: - Empty
struct WeatherModel: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let wind: Wind
   // let rain: Rain
    let clouds: Clouds
    let name: String
}



// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

// MARK: - Main
struct Main: Codable {
    let temp:Double
    let feelsLike:Double
    let minTemp:Double
    let maxTemp:Double
    let humidity:Double
    
    enum CodingKeys: String, CodingKey {
      case temp
      case feelsLike = "feels_like"
      case minTemp = "temp_min"
      case maxTemp = "temp_max"
      case humidity
    }
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
}


struct Rain: Codable {
    let the1H: Double

    enum CodingKeys: String, CodingKey {
        case the1H = "1h"
    }
}

// MARK: - Clouds
struct Clouds: Codable {
    let all: Int
}

