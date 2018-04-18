//
//  Country.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 26/03/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
struct Weather {
    let countryName : String    
    let maxTemperature : Double
    let minTemperature : Double
    let temperature : Double
    
    init?(jsonObject : [String : Any]) {
        
        if let countryDictionary = jsonObject["sys"] as? [String : Any] {
            self.countryName = countryDictionary["country"] as? String ?? ""
        }else {
            self.countryName = "Country not found."
        }
        
        guard let jsonWeather = jsonObject["main"] as? [String : Any] else {
            return nil
        }
        
        if let jsonMaxTemp = jsonWeather["temp_max"] as? Double {
            self.maxTemperature = jsonMaxTemp
        }else {
            self.maxTemperature = 0.0
        }
        
        if let jsonMinTemp = jsonWeather["temp_min"] as? Double {
            self.minTemperature = jsonMinTemp
        }else {
            self.minTemperature = 0.0
        }
        
        if let jsonTemp = jsonWeather["temp"] as? Double {
            self.temperature = jsonTemp
        }else {
            self.temperature = 0.0
        }
    }
}

