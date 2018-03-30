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
    let maxTemp : Double
    let minTemp : Double
    let temp : Double
    
    init(jsonWeather : NSDictionary) {
        if let countryDictionary = jsonWeather.value(forKey: "sys") as? NSDictionary {
            self.countryName = countryDictionary.value(forKey: "country") as? String ?? ""
        }else {
            self.countryName = ""
        }
        
        if let jsonMaxTemp = jsonWeather.value(forKey: "temp_max") as? Double {
            self.maxTemp = jsonMaxTemp
        }else {
            self.maxTemp = 0.0
        }
        
        if let jsonMinTemp = jsonWeather.value(forKey: "temp_min") as? Double {
            self.minTemp = jsonMinTemp
        }else {
            self.minTemp = 0.0
        }
        
        if let jsonTemp = jsonWeather.value(forKey: "temp") as? Double {
            self.temp = jsonTemp
        }else {
            self.temp = 0.0
        }
    }
}

