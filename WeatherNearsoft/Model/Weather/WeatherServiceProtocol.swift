//
//  WeatherServiceProtocol.swift
//  WeatherNearsoft
//
//  Created by Saul Urias on 5/21/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherServiceProtocol {
    func getWeather(withLocation location: CLLocation, onSuccess: @escaping (_ jsonObject: [String: Any])-> Void, onFailure: @escaping(_ error: WeatherError)-> Void)    
    func getForecast(withLocation location: CLLocation, onSuccess: @escaping (_ jsonObject: [String: Any])-> Void, onFailure: @escaping(_ error: WeatherError)-> Void)
}
