//
//  ForecastViewModel.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 21/04/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation

struct ForecastViewModel {
    
    let weatherService = WeatherService()
    
    func getWeather(withLocation location : CLLocation, onSuccess: @escaping (_ forecastArray: [Forecast])-> Void, onFailure: @escaping(_ error : WeatherError)-> Void){
        weatherService.getForecast(withLocation: location, onSuccess: { (jsonObject) in
            
            guard let jsonForecastArray = jsonObject["list"] as? [[String : Any]] else {
                let error = WeatherError(code: 404, message: StringValues.stringUnableToFindTemperature)
                return onFailure(error)
            }
            
            var forecastArray: [Forecast] = []
            
            for jsonForecast in jsonForecastArray {
                if let forecast = Forecast(jsonObject: jsonForecast) {
                    forecastArray.append(forecast)
                }
            }
            
            if forecastArray.count > 0 {
                onSuccess(forecastArray)
            }else {
                let error = WeatherError(code: 404, message: StringValues.stringUnableToFindTemperature)
                return onFailure(error)
            }
            
        }, onFailure: { (errorValue) in
            onFailure(errorValue)
        })
    }
    
    
    
}
