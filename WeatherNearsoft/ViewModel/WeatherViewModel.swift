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
    
    let weatherService = WeatherService()

    func getWeather(withLocation location : CLLocation, onSuccess: @escaping (_ weather: Weather)-> Void, onFailure: @escaping(_ error : WeatherError)-> Void){
        weatherService.getWeather(withLocation: location, onSuccess: { (jsonObject) in
            
            guard let weather = Weather(jsonObject: jsonObject) else {
                let error = WeatherError(code: 404, message: StringValues.stringUnableToFindTemperature)
                return onFailure(error)
            }
            
            onSuccess(weather)
        }, onFailure: { (errorValue) in
            onFailure(errorValue)
        })
    }
    
    func getCityName(byUserLocation location : CLLocation, onSucces: @escaping(_ location : String) -> Void, onFailure: @escaping(_ error: WeatherError) -> Void)  {
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil {
                let error = WeatherError(code: 404, message: StringValues.stringCityNotFound)
                return onFailure(error)
            }else {
                guard let place = placemark?.first else {
                    let error = WeatherError(code: 404, message: StringValues.stringCityNotFound)
                    return onFailure(error)
                }
                
                guard let locality = place.locality else {
                    let error = WeatherError(code: 404, message: StringValues.stringCityNotFound)
                    return onFailure(error)
                }
                
                onSucces(locality)
            }
        }
    }
    
    func locationAuthorized() -> Bool {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            return true
        }
        return false
    }
    
}


