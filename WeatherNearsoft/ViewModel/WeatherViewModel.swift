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

    static func getWeather(withLocation location : CLLocation, onSuccess: @escaping (_ weather: Weather)-> Void, onFailure: @escaping(_ error : Error)-> Void){
        WeatherService.getWeather(withLocation: location, onSuccess: { (weatherValues) in
            onSuccess(weatherValues)
        }, onFailure: { (errorValue) in
            onFailure(errorValue)
        })
    }
    
    static func getCityName(byUserLocation location : CLLocation, onSucces: @escaping(_ location : String) -> Void, onFailure: @escaping(_ errorMessage: String) -> Void)  {
        CLGeocoder().reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil {
                onFailure("Error getting location")
            }else {
                if let place = placemark?.first {
                    //return place.locality ?? "City not found"
                    if let locality = place.locality {
                        onSucces(locality)
                    }else {
                        onFailure("Error getting location")
                    }
                }
            }
        }
    }
    
    static func locationAuthorized() -> Bool {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            return true
        }
        return false
    }
    
}


