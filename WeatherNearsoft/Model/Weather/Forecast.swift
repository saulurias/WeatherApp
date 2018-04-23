//
//  Forecast.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 21/04/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation

struct Forecast {
    let date: String
    let maxTemperature: Double
    let minTemperature: Double
    let urlIcon: String
    
    init?(jsonObject : [String : Any]) {        
        if let jsonDate = jsonObject["dt_txt"] as? String {
            self.date = jsonDate
        }else {
            self.date = "Date not found"
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
        
        //http://openweathermap.org/img/w/code.png
        if let jsonIconData = jsonObject["weather"] as? [[String : Any]] {
            if let iconCode = jsonIconData[0]["icon"] as? String {
                self.urlIcon = "http://openweathermap.org/img/w/\(iconCode).png"
            }else {
                self.urlIcon = ""
            }
        }else {
            self.urlIcon = ""
        }
        
    }
    
}
