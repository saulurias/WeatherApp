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
    static func getWeather(withLocation location: CLLocation, onSuccess: @escaping (_ weather: Weather)-> Void, onFailure: @escaping(_ message: String )-> Void){
        
        let latitude = location.coordinate.latitude as Double
        let longitude = location.coordinate.longitude as Double
        let session = URLSession.shared
        let stringUnableToFindTemp = "Unable to find temperature"
        let stringUnableToConnect = "Unable to connect to the server"
        
        let urlString = "\(APIManager.baseUrl)/weather?lat=\(latitude)&lon=\(longitude)&units=imperial\(APIManager.apiKey)"
        
        guard let weatherURL = URL(string: urlString) else {
            return onFailure(stringUnableToConnect)
        }
        
        let dataTask = session.dataTask(with: weatherURL) { (dataResponse, response, error) in
            if let error = error {
                print("Error:\n\(error)")
                onFailure(stringUnableToConnect)
            } else {
                
                guard let data = dataResponse else {
                    return  onFailure(stringUnableToConnect)
                }
                
                let dataString = String(data: data, encoding: String.Encoding.utf8)
                
                print("All the weather data:\n\(dataString!)")
                
                guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary else {
                    print("Error: did not receive data")
                    return onFailure(stringUnableToFindTemp)
                }
                
                guard let mainDictionary = jsonObject?.value(forKey: "main") as? NSDictionary else {
                    print("Error: unable to convert json data")
                    return onFailure(stringUnableToFindTemp)
                }                
                
                onSuccess(Weather(jsonWeather: mainDictionary))
                
            }
        }
        dataTask.resume()
    }
}

