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
    
    init(jsonWeather : [String : Any]) {
        if let countryDictionary = jsonWeather["sys"] as? [String : Any] {
            self.countryName = countryDictionary["country"] as? String ?? ""
        }else {
            print("No fue posible acceder a sys")
            self.countryName = "Country not found."
        }
        
        if let jsonMaxTemp = jsonWeather["temp_max"] as? Double {
            self.maxTemp = jsonMaxTemp
        }else {
            self.maxTemp = 0.0
        }
        
        if let jsonMinTemp = jsonWeather["temp_min"] as? Double {
            self.minTemp = jsonMinTemp
        }else {
            self.minTemp = 0.0
        }
        
        if let jsonTemp = jsonWeather["temp"] as? Double {
            self.temp = jsonTemp
        }else {
            self.temp = 0.0
        }
    }
}

