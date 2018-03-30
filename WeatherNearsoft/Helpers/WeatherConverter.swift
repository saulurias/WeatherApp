//
//  WeatherConverter.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 29/03/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
struct WeatherConverter {
    static func convertToCelsius(fromFarenheit fahrenheit: Double) -> Double {
        let divisor = pow(10.0, Double(2))
        let celcius = 5.0 / 9.0 * (Double(fahrenheit) - 32.0) //Converting from Farenheit to Celcius
        return ((celcius * divisor).rounded() / divisor) //Rounding to two decimals
    }
}
