//
//  LocationViewModel.swift
//  WeatherNearsoft
//
//  Created by Saul Urias on 5/4/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation

struct LocationViewModel {

    var geocoder: CLGeocoder
    
    init(geocoder: CLGeocoder = CLGeocoder()) {
        self.geocoder = geocoder        
    }
    
    func getCityName(byUserLocation location: CLLocation,
                     onSucces: @escaping(_ location: String) -> Void,
                     onFailure: @escaping(_ error: WeatherError) -> Void)  {
        geocoder.reverseGeocodeLocation(location) { (placemark, error) in
            if error != nil {
                let error = WeatherError(code: 404, message: StringValues.stringCityNotFound)
                return onFailure(error)
            }else {
                guard let place = placemark?.first else {
                    let error = WeatherError(code: 404, message: StringValues.stringCityNotFound)
                    return onFailure(error)
                }
                print("\(String(describing: placemark?.first)))")
                print("PLACE: \(place)")
                print("LOCALITY: \(String(describing: place.locality))")
                
                guard let locality = place.locality else {
                    let error = WeatherError(code: 404, message: StringValues.stringCityNotFound)
                    return onFailure(error)
                }
                onSucces(locality)
            }
        }
    }
    
    func isLocationAuthorized() -> Bool {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            return true
        }
        return false
    }
}
