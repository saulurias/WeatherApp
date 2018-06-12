//
//  WeatherServiceTest.swift
//  WeatherNearsoftTests
//
//  Created by Saul Urias on 6/5/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation
import OHHTTPStubs
import XCTest
@testable import WeatherNearsoft

class WeatherServiceTest: XCTestCase {
    private let mockWeatherService = MockWeatherService()
    private let weatherService = WeatherService()
    private let location = CLLocation(latitude: 29.1026, longitude: -110.97732)
    
    
    private var stubs: HMStubs!
    private let bundle = Bundle.main
    private let weatherViewModel = WeatherViewModel()
    private let weatherServiceExpectation = XCTestExpectation(description: "Weather Service Call")
    
    override func setUp() {
        super.setUp()
        stubs = HMStubs(bundle: bundle)
        stubs.createStubs(fromFile: .weatherFile, withStatusCode: 201, forPaths: ["/weather"])
    }
    
    override func tearDown() {
        stubs.removeStubs()
    }
    
    func testGetWeatherStubs(){
        weatherViewModel.getWeather(withLocation: CLLocation(), onSuccess: { (weather) in
            print(weather.countryName)
            XCTAssert(weather.countryName == "AU")
            self.weatherServiceExpectation.fulfill()
        }) { (error) in
            print(error.code)
            self.weatherServiceExpectation.fulfill()
        }
        wait(for: [weatherServiceExpectation], timeout: 10.0)
    }
//
//    func testGetWeather(){
//        mockWeatherService.getWeather(withLocation: location, onSuccess: { (forecastDictionary) in
//            XCTAssertNotNil(forecastDictionary)
//        }) { _ in }
//    }
//
//    func testGetForecast(){
//        mockWeatherService.getForecast(withLocation: location, onSuccess: { (forecastDictionary) in
//            XCTAssertNotNil(forecastDictionary)
//        }) { _ in }
//    }
//
//    func testGetWeatherService(){
//        let expectation = XCTestExpectation(description: "Get weather service test")
//        weatherService.getWeather(withLocation: location, onSuccess: { weather in
//            XCTAssertNotNil(weather)
//            expectation.fulfill()
//        }) { _ in }
//        wait(for: [expectation], timeout: 20.0)
//    }
//
//    func testGetForecastService(){
//        let expectation = XCTestExpectation(description: "Get weather service test")
//        weatherService.getForecast(withLocation: location, onSuccess: { weather in
//            XCTAssertNotNil(weather)
//            expectation.fulfill()
//        }) { _ in }
//        wait(for: [expectation], timeout: 20.0)
//    }
}
