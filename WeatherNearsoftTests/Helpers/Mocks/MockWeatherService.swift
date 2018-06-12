//
//  MockWeatherService.swift
//  WeatherNearsoftTests
//
//  Created by Saul Urias on 5/21/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation
@testable import WeatherNearsoft

struct MockWeatherService: WeatherServiceProtocol {
    private let jsonFileReader = JsonFileReader()
    private let jsonDataConverter = JsonDataConverter()
    var willFail = false
    var withWrongWeatherFileName = false
    var withouthForecastListKey = false
    
    func getWeather(withLocation location: CLLocation, onSuccess: @escaping ([String : Any]) -> Void, onFailure: @escaping (WeatherError) -> Void) {
        let error = WeatherError(code: 404, message: StringValues.stringUnableToFindTemperature)
        let fileName = withWrongWeatherFileName ? "ForecastJson" : "WeatherJson"
        
        if let data = jsonFileReader.getJsonDataFromFile(withFileName: fileName) {
            guard let jsonObject: [String: Any]? = jsonDataConverter.convertJsonDataToGenericResponse(withData: data) else {
                return onFailure(error)
            }
            
            guard let jsonObjectDictionary = jsonObject else {
                return onFailure(error)
            }
            
            if willFail {
                return onFailure(error)
            }
            
            onSuccess(jsonObjectDictionary)
        }else {
            onFailure(error)
        }
    }
    
    func getForecast(withLocation location: CLLocation, onSuccess: @escaping ([String : Any]) -> Void, onFailure: @escaping (WeatherError) -> Void) {
        let error = WeatherError(code: 404, message: StringValues.stringUnableToFindTemperature)
        let fileName = withouthForecastListKey ? "ForecastWithouthListKey" : "ForecastJson"
        
        if let data = jsonFileReader.getJsonDataFromFile(withFileName: fileName) {
            
            guard let jsonObject: [String: Any]? = jsonDataConverter.convertJsonDataToGenericResponse(withData: data) else {
                return onFailure(error)
            }
            
            guard let jsonObjectDictionary = jsonObject else {
                return onFailure(error)
            }
            
            if willFail {
                return onFailure(error)
            }
            
            onSuccess(jsonObjectDictionary)
        }else {
            onFailure(error)
        }
    }    
}

