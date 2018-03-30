//
//  Service.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 26/03/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation

struct WebService {
    static func getWeather(location : CLLocation, completionHandler:@escaping (_ status : Bool,_ message : String ,_ weather : Weather?)->()){
        
        let latitude = location.coordinate.latitude as Double
        let longitude = location.coordinate.longitude as Double
        let session = URLSession.shared
        let stringUnableToFindTemp = "Unable to find temperature"
        let stringUnableToConnect = "Unable to connect to the server"
        
        let urlString = "\(WebLinks.Service.urlGetWeather)lat=\(latitude)&lon=\(longitude)&units=imperial\(WebLinks.apiKey)"
        
        if let weatherURL = URL(string: urlString) {
            let dataTask = session.dataTask(with: weatherURL) { (data: Data?, response: URLResponse?, error: Error?) in
                if let error = error {
                    print("Error:\n\(error)")
                    completionHandler(false, stringUnableToConnect, nil)
                } else {
                    if let data = data {
                        let dataString = String(data: data, encoding: String.Encoding.utf8)
                        
                        print("All the weather data:\n\(dataString!)")
                        
                        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                            
                            var temp = 0.0
                            var maxTemp = 0.0
                            var minTemp = 0.0
                            var countryName = ""
                            
                            //Getting Temperature
                            if let mainDictionary = jsonObject?.value(forKey: "main") as? NSDictionary {
                                if let temperature = mainDictionary.value(forKey: "temp") {
                                    temp = temperature as? Double ?? 0.0
                                    
                                }
                                
                                if let maxTemperature = mainDictionary.value(forKey: "temp_max") {
                                    maxTemp = maxTemperature as? Double ?? 0.0
                                }
                                
                                if let minTemperature = mainDictionary.value(forKey: "temp_min") {
                                    minTemp = minTemperature as? Double ?? 0.0
                                }
                                
                                if let countryDictionary = jsonObject?.value(forKey: "sys") as? NSDictionary {
                                    if let name = countryDictionary.value(forKey: "country") {
                                        countryName = name as? String ?? ""
                                    }
                                }
                            }
                            //End Getting temperature
                            
                            if countryName != "" {
                                let weather = Weather(countryName: countryName, maxTemp: maxTemp, minTemp: minTemp, temp: temp)
                                completionHandler(true, "Succes", weather)
                            }else {
                                print("Error: unable to find temperature in dictionary")
                                completionHandler(false, stringUnableToFindTemp, nil)
                            }
                        } else {
                            print("Error: unable to convert json data")
                            completionHandler(false, stringUnableToFindTemp, nil)
                        }
                    } else {
                        print("Error: did not receive data")
                        completionHandler(false, stringUnableToFindTemp, nil)
                    }
                }
            }
            dataTask.resume()
        }else {
            print("Error: unable to create url")
            completionHandler(false, stringUnableToConnect, nil)
        }
    }
}
