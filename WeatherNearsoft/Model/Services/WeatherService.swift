//
//  Service.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 26/03/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire

struct WeatherService: WeatherServiceProtocol {
    func getWeather(withLocation location: CLLocation,
                    onSuccess: @escaping (_ jsonObject: [String: Any])-> Void,
                    onFailure: @escaping(_ error: WeatherError)-> Void){
        
        let latitude = location.coordinate.latitude as Double
        let longitude = location.coordinate.longitude as Double                
        let weatherRequest = WeatherRouter.getWeather(latitude: latitude, longitude: longitude)
        
        self.getGenericResponseData(requester: weatherRequest, onSuccess: { (jsonObjectResponse) in
            return onSuccess(jsonObjectResponse)
        }, onFailure: { (error) in
            return onFailure(error)
        })
    }
    
    func getForecast(withLocation location: CLLocation,
                     onSuccess: @escaping (_ jsonObject: [String: Any])-> Void,
                     onFailure: @escaping(_ error: WeatherError)-> Void){
        
        let latitude = location.coordinate.latitude as Double
        let longitude = location.coordinate.longitude as Double
        let forecastRequest = WeatherRouter.getForecast(latitude: latitude, longitude: longitude)
        
        self.getGenericResponseData(requester: forecastRequest, onSuccess: { (jsonObjectResponse) in
            return onSuccess(jsonObjectResponse)
        }, onFailure: { (error) in
            return onFailure(error)
        })
    }
    
     private func getGenericResponseData(requester: URLRequestConvertible,
                                         onSuccess: @escaping (_ jsonObject: [String: Any])-> Void,
                                         onFailure: @escaping(_ error: WeatherError)-> Void) {
        Alamofire.request(requester).responseJSON { (response: DataResponse<Any>) in
            guard let data = response.data else {
                let error = WeatherError(code: 404, message: StringValues.stringUnableToFindForecast)
                return onFailure(error)
            }
            
            guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                print("Error: did not receive data")
                let error = WeatherError(code: 404, message: StringValues.stringUnableToFindTemperature)
                return onFailure(error)
            }
            return onSuccess(jsonObject!)
        }
    }
    
}
