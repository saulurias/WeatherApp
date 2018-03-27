//
//  Service.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 26/03/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation

struct WebService {
    static func getWeather(latitude : Double, longitude : Double, completionHandler:@escaping (_ status : Bool,_ message : String ,_ country : Country?)->()){
        let session = URLSession.shared
        print(WebLinks.Service.urlGetWeather)
        if let weatherURL = URL(string: "\(WebLinks.Service.urlGetWeather)lat=\(latitude)&lon=\(longitude)\(WebLinks.apiKey)") {
            let dataTask = session.dataTask(with: weatherURL) {
                (data: Data?, response: URLResponse?, error: Error?) in
                if let error = error {
                    print("Error:\n\(error)")
                    completionHandler(false, "Unable to connect to the server", nil)
                } else {
                    if let data = data {
                        let dataString = String(data: data, encoding: String.Encoding.utf8)
                        print("All the weather data:\n\(dataString!)")
                        if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? NSDictionary {
                            
                            var temp = 0.0
                            var maxTemp = 0.0
                            var minTemp = 0.0
                            var countryName = ""
                            var cityName = ""
                            
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
                            }
                            
                            //End Getting temperature
                            
                            //Getting Country Name
                            if let countryDictionary = jsonObject?.value(forKey: "sys") as? NSDictionary {
                                if let name = countryDictionary.value(forKey: "country") {
                                    countryName = name as? String ?? ""
                                }
                            }
                            //End Getting Country Name
                            
                            //Getting City Name
                            if let city = jsonObject?.value(forKey: "name") {
                                cityName = city as? String ?? ""
                            }
                            //End Getting City Name
                            
                            
                            if countryName != "" {
                                let country = Country(name: countryName, city: cityName, maxTemp: maxTemp, minTemp: minTemp, temp: temp)
                                completionHandler(true, "Succes", country)
                            }else {
                                print("Error: unable to find temperature in dictionary")
                                completionHandler(false, "Unable to find temperature", nil)
                            }
                        } else {
                            print("Error: unable to convert json data")
                            completionHandler(false, "Unable to find temperature", nil)
                        }
                    } else {
                        print("Error: did not receive data")
                        completionHandler(false, "Unable to find temperature", nil)
                    }
                }
            }
            dataTask.resume()
        }else {
            print("Error: unable to create url")
            completionHandler(false, "Unable to connect to the server", nil)
        }
    }
}
