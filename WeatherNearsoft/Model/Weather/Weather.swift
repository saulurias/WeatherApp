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
            self.maxTemperature = Int(jsonMaxTemp)
        }else {
            return nil
        }
        
        if let jsonMinTemp = jsonWeather["temp_min"] as? Double {
            self.minTemperature = Int(jsonMinTemp)
        }else {
            return nil
        }
        
        if let jsonTemp = jsonWeather["temp"] as? Double {
            self.temperature = Int(jsonTemp)
        }else {
            return nil
        }
    }
}

