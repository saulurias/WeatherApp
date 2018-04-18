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

    func getWeather(withLocation location : CLLocation, onSuccess: @escaping (_ weather: Weather)-> Void, onFailure: @escaping(_ error : Error)-> Void){
        weatherService.getWeather(withLocation: location, onSuccess: { (jsonObject) in
            
            guard let weather = Weather(jsonObject: jsonObject) else {
                let error = Error(code: 404, message: StringValues.stringUnableToFindTemperature)
                return onFailure(error)
            }
            
            onSuccess(weather)
        }, onFailure: { (errorValue) in
            onFailure(errorValue)
        })
    }
    
    func getCityName(byUserLocation location : CLLocation, onSucces: @escaping(_ location : String) -> Void, onFailure: @escaping(_ error: Error) -> Void)  {
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil {
                let error = Error(code: 404, message: StringValues.stringUnableToFindTemperature)
                return onFailure(error)
            }else {
                if let place = placemark?.first {
                    if let locality = place.locality {
                        onSucces(locality)
                    }else {
                        let error = Error(code: 404, message: StringValues.stringUnableToFindTemperature)
                        return onFailure(error)
                    }
                }
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


