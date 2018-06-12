//
//  WeatherModelView.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 29/03/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherViewModel {
    
     var weatherService: WeatherServiceProtocol
    
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }

    func getWeather(withLocation location: CLLocation,
                    onSuccess: @escaping (_ weather: Weather)-> Void,
                    onFailure: @escaping(_ error: WeatherError)-> Void){
        
        weatherService.getWeather(withLocation: location,
                                  onSuccess: { (jsonObject) in
            
            guard let weather = Weather(jsonObject: jsonObject) else {
                let error = WeatherError(code: 404, message: StringValues.stringUnableToFindTemperature)
                return onFailure(error)
            }
            
            onSuccess(weather)
        }, onFailure: { (errorValue) in
            onFailure(errorValue)
        })
    }
}


