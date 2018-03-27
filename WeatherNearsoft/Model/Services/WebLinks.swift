//
//  WebLinks.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 26/03/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation

struct WebLinks {
    private static let baseUrl = "http://api.openweathermap.org/"
    
    static let apiKey = "&APPID=2fb032f8bca602cc0daf939627da8059"
    
    struct Service {
        static let urlGetWeather = baseUrl + "data/2.5/weather?"
    }
}
