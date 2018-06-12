//
//  WeatherViewModelTest.swift
//  WeatherNearsoftTests
//
//  Created by Saul Urias on 5/24/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation
import XCTest
@testable import WeatherNearsoft

class WeatherViewModelTest: XCTestCase {
    private var mockWeatherService = MockWeatherService()
    private var weatherViewModel: WeatherViewModel!
    
    func testGetWeather(){
        mockWeatherService.willFail = false
        weatherViewModel = WeatherViewModel(weatherService: mockWeatherService)
        weatherViewModel.getWeather(withLocation: CLLocation(), onSuccess: { (weather) in
            XCTAssertNotNil(weather)            
            XCTAssert(weather.countryName == "AU", "Country name should be AU")
            XCTAssert(weather.maxTemperature == 300)
            XCTAssert(weather.minTemperature == 300)
            XCTAssert(weather.temperature == 300)
        }) { _ in }
    }
    
    func testGetWeatherFail(){
        mockWeatherService.willFail = true
        weatherViewModel = WeatherViewModel(weatherService: mockWeatherService)
        
        weatherViewModel.getWeather(withLocation: CLLocation(), onSuccess: { _ in},
        onFailure: { error in
            XCTAssertNotNil(error)
            XCTAssert(error.code == 404, "Error code should be 404")
            XCTAssert(error.message == StringValues.stringUnableToFindTemperature, "Error message shuld be: \(StringValues.stringUnableToFindTemperature)")
        })
    }
    
    func testGetWeatherWrongFileName(){
        mockWeatherService.withWrongWeatherFileName = true
        weatherViewModel = WeatherViewModel(weatherService: mockWeatherService)
        
        weatherViewModel.getWeather(withLocation: CLLocation(), onSuccess: { _ in},
                                    onFailure: { error in
                                        XCTAssertNotNil(error)
                                        XCTAssert(error.code == 404, "Error code should be 404")
                                        XCTAssert(error.message == StringValues.stringUnableToFindTemperature, "Error message shuld be: \(StringValues.stringUnableToFindTemperature)")
        })
    }
}
