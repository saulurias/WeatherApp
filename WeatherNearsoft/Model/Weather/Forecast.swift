//
//  Forecast.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 21/04/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation

struct Forecast: MaxAndMinTemperatureProtocol, DateProtocol, URLIconProtocol {
    var date: Date
    var maxTemperature: Int
    var minTemperature: Int
    var urlIcon: String
    
    init?(jsonObject: [String: Any]) {
        
        guard let jsonWeather = jsonObject["main"] as? [String: Any] else {
            return nil
        }
        
        guard let jsonMaxTemp = jsonWeather["temp_max"] as? Double else {
            return nil
        }
        
        guard let jsonMinTemp = jsonWeather["temp_min"] as? Double else {
            return nil
        }
        
        self.maxTemperature = Int(jsonMaxTemp)
        self.minTemperature = Int(jsonMinTemp)
        
        if let stringDate = jsonObject["dt_txt"] as? String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_GB")
            
            guard let dateFromString = dateFormatter.date(from: stringDate) else {
                return nil
            }
            
            self.date = dateFromString
            
        }else {
            return nil
        }
        
        //http://openweathermap.org/img/w/code.png
        if let jsonIconData = jsonObject["weather"] as? [[String: Any]] {
            let iconCode = jsonIconData[0]["icon"] as! String
            self.urlIcon = "http://openweathermap.org/img/w/\(iconCode).png"
        }else {
            self.urlIcon = ""
        }
    }
}
