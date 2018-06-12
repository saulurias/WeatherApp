//
//  WeatherProtocols.swift
//  WeatherNearsoft
//
//  Created by Saul Urias on 5/2/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation

protocol MaxAndMinTemperatureProtocol {
    var maxTemperature: Int {get set}
    var minTemperature: Int {get set}
}

protocol TemperatureProtocol {
    var temperature: Int {get set}
}

protocol CountryProtocol {
    var countryName: String {get set}
}

protocol DateProtocol {
    var date: Date {get set}
}

protocol URLIconProtocol {
    var urlIcon: String {get set}
}
