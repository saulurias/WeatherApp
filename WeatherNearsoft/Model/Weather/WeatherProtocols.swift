//
//  WeatherProtocols.swift
//  WeatherNearsoft
//
//  Created by Saul Urias on 5/2/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation

protocol MaxAndMinTemperatureProtocol {
    var maxTemperature: Int {get}
    var minTemperature: Int {get}
}

protocol TemperatureProtocol {
    var temperature: Int {get}
}

protocol CountryProtocol {
    var countryName: String {get}
}

protocol DateProtocol {
    var date: Date {get}
}

protocol URLIconProtocol {
    var urlIcon: String {get}
}
