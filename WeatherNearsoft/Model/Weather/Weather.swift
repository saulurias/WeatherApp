//
//  Country.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 26/03/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
struct Weather: TemperatureProtocol, MaxAndMinTemperatureProtocol, CountryProtocol {
    var countryName: String
    var maxTemperature: Int
    var minTemperature: Int
    var temperature: Int
    
    init?(jsonObject: [String: Any]) {
        if let countryDictionary = jsonObject["sys"] as? [String: Any] {
            if let countryName = countryDictionary["country"] as? String {
                self.countryName = countryName
            }else {
                self.countryName = "Country not found."
            }
        }else {
            self.countryName = "Country not found."
        }
        
        guard let jsonWeather = jsonObject["main"] as? [String: Any] else {
            return nil
        }
        
        guard let jsonMaxTemp = jsonWeather["temp_max"] as? Double else {
            return nil            
        }
        
        guard let jsonMinTemp = jsonWeather["temp_min"] as? Double else {
            return nil
        }
        
        guard let jsonTemp = jsonWeather["temp"] as? Double else {
            return nil
        }
        
        self.maxTemperature = Int(jsonMaxTemp)
        self.minTemperature = Int(jsonMinTemp)
        self.temperature = Int(jsonTemp)
    }
}

