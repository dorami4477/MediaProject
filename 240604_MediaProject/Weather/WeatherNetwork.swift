//
//  WeatherNetwork.swift
//  240604_MediaProject
//
//  Created by 박다현 on 6/29/24.
//

import Foundation
import CoreLocation

enum WeatherNetworkError:Error{
    case failedRequest
    case invalidResponse
    case noData
    case invalidData
}


final class WeatherNetwork{
    static let shared = WeatherNetwork()
    private init (){}
    
    func callRequest(location:CLLocationCoordinate2D, completionHandler: @escaping (WeatherModel?, WeatherNetworkError?) -> Void){
        let scheme = "https"
        let host = "api.openweathermap.org"
        let path = "/data/2.5/weather"
        
        var component = URLComponents()
        component.scheme = scheme
        component.host = host
        component.path = path
        component.queryItems = [
            URLQueryItem(name: "lat", value: "\(location.latitude)"),
            URLQueryItem(name: "lon", value: "\(location.longitude)"),
            URLQueryItem(name: "lang", value: "kr"),
            URLQueryItem(name: "units", value: "metric"),
            URLQueryItem(name: "appid", value: APIKey.weather)
        ]
        
        URLSession.shared.dataTask(with: component.url!) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil else{
                    completionHandler(nil, .failedRequest)
                    return
                }
                guard let data else{
                    completionHandler(nil, .noData)
                    return
                }
                guard let response = response as? HTTPURLResponse else{
                    completionHandler(nil, .invalidResponse)
                    return
                }
                guard response.statusCode == 200 else{
                    completionHandler(nil, .failedRequest)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(WeatherModel.self, from: data)
                    completionHandler(result, nil)
                } catch {
                    completionHandler(nil, .invalidData)
                }
            }
        }.resume()
    }

}
