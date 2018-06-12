//
//  WeatherRouter.swift
//  WeatherNearsoft
//
//  Created by Saul Urias on 5/3/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import Alamofire

enum WeatherRouter: URLRequestConvertible {
    
    case getWeather(latitude: Double, longitude: Double)
    case getForecast(latitude: Double, longitude: Double)
    
    var method: HTTPMethod {
        switch self {
        case .getWeather, .getForecast:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getWeather:
            return "/weather"
        case .getForecast:
            return "/forecast"
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .getWeather(let latitude, let longitude):
            return [
                "lat": latitude,
                "lon": longitude,
                "appid": APIManager.openWeatherApiKey,
                "units": "imperial",
                ]
            
        case .getForecast(let latitude, let longitude):
            return [
                "lat": latitude,
                "lon": longitude,
                "appid": APIManager.openWeatherApiKey,
                "units": "imperial",
                ]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try APIManager.openWeatherBaseUrl.asURL()
        
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        
        urlRequest.httpMethod = method.rawValue
        switch self {
        case .getWeather, .getForecast:
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: self.parameters)
            print(urlRequest)
        }
        return urlRequest
    }
}
