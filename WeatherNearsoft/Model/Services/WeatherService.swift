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
    static func getWeather(withLocation location: CLLocation, onSuccess: @escaping (_ weather: Weather)-> Void, onFailure: @escaping(_ error : Error)-> Void){
        
        let latitude = location.coordinate.latitude as Double
        let longitude = location.coordinate.longitude as Double
        let session = URLSession.shared
        let stringUnableToFindTemp = "Unable to find temperature"
        let stringUnableToConnect = "Unable to connect to the server"
        
        let urlString = "\(APIManager.baseUrl)/weather?lat=\(latitude)&lon=\(longitude)&units=imperial\(APIManager.apiKey)"
        
        guard let weatherURL = URL(string: urlString) else {
            let error = Error(code: 404, message: stringUnableToConnect)
            return onFailure(error)
        }
        
        let dataTask = session.dataTask(with: weatherURL) { (dataResponse, response, error) in
            if let error = error {
                print("Error:\n\(error)")
                let error = Error(code: 404, message: stringUnableToConnect)
                onFailure(error)
            } else {
                
                guard let data = dataResponse else {
                    let error = Error(code: 404, message: stringUnableToConnect)
                    return onFailure(error)
                }
                
                let dataString = String(data: data, encoding: String.Encoding.utf8)
                
                print("All the weather data:\n\(dataString!)")
                
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else {
                    print("Error: did not receive data")
                    let error = Error(code: 404, message: stringUnableToFindTemp)
                    return onFailure(error)
                }
                
                guard let mainDictionary = jsonObject?["main"] as? [String : Any] else {
                    print("Error: unable to convert json data")
                    let error = Error(code: 404, message: stringUnableToFindTemp)
                    return onFailure(error)
                }                
                
                onSuccess(Weather(jsonWeather: mainDictionary))
                
            }
        }
        dataTask.resume()
    }
}

