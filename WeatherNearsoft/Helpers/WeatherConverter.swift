//
//  WeatherConverter.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 29/03/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
class WeatherConverter {
    func convertToCelsius(fromFarenheit fahrenheit: Int) -> Int {        
        return (Int(5.0 / 9.0 * (Double(fahrenheit) - 32.0)))
    }
}
