//
//  Service.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 26/03/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation

struct WeatherService {

    func getWeather(withLocation location: CLLocation, onSuccess: @escaping (_ jsonObject: [String : Any])-> Void, onFailure: @escaping(_ error : WeatherError)-> Void){
        
        let latitude = location.coordinate.latitude as Double
        let longitude = location.coordinate.longitude as Double
        let urlString = "\(APIManager.baseUrl)/weather?lat=\(latitude)&lon=\(longitude)&units=imperial\(APIManager.apiKey)"
        
        print("URL: " + urlString) 
        
        guard let weatherURL = URL(string: urlString) else {
            let error = WeatherError(code: 404, message: StringValues.stringUnableToConnectToServer)
            return onFailure(error)
        }
        
        let dataTask = APIManager.session.dataTask(with: weatherURL) { (dataResponse, response, error) in
            
            if let error = error {
                print("Error:\n\(error)")
                let error = WeatherError(code: 404, message: StringValues.stringUnableToFindTemperature)
                onFailure(error)
            } else {
                
                guard let data = dataResponse else {
                    let error = WeatherError(code: 404, message: StringValues.stringUnableToFindTemperature)
                    return onFailure(error)
                }
                
                let dataString = String(data: data, encoding: String.Encoding.utf8)
                
                print("All the weather data:\n\(dataString!)")
                
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else {
                    print("Error: did not receive data")
                    let error = WeatherError(code: 404, message: StringValues.stringUnableToFindTemperature)
                    return onFailure(error)
                }
                
                onSuccess(jsonObject!)
                
            }
        }
        dataTask.resume()
    }
}

