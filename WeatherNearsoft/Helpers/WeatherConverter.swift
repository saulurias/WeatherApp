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
        let celcius = 5.0 / 9.0 * (Double(fahrenheit) - 32.0) //Converting from Farenheit to Celcius
        return (Int(celcius)) //Rounding to two decimals
    }
}
