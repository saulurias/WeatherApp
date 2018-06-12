//
//  ForecastViewModelTest.swift
//  WeatherNearsoftTests
//
//  Created by Saul Urias on 5/30/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation
import XCTest
@testable import WeatherNearsoft

class ForecastViewModelTest: XCTestCase {
    private var mockWeatherService = MockWeatherService()
    private var forecastViewModel: ForecastViewModel!
    
    func testGetForecast(){
        forecastViewModel = ForecastViewModel(weatherService: mockWeatherService)
        forecastViewModel.getForecast(withLocation: CLLocation(), onSuccess: { (forecasts) in
            let forecast = forecasts[0]
            let date = self.dateFromString(withStringDate: "2017-01-30 18:00:00")
            XCTAssert(forecast.maxTemperature == 282)
            XCTAssert(forecast.minTemperature == 282)
            XCTAssert(forecast.date == date)
            XCTAssert(forecast.urlIcon == "http://openweathermap.org/img/w/01n.png")
        }) { _ in }
    }
    
    private func dateFromString(withStringDate stringDate: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_GB")
        let dateFromString = dateFormatter.date(from: stringDate)!
        return dateFromString
    }
    
    func testGetForecastFail(){
        mockWeatherService.willFail = true
        forecastViewModel = ForecastViewModel(weatherService: mockWeatherService)
        
        forecastViewModel.getForecast(withLocation: CLLocation(), onSuccess: { _ in},
                                    onFailure: { error in
                                        XCTAssertNotNil(error)
                                        XCTAssert(error.code == 404, "Error code should be 404")
                                        XCTAssert(error.message == StringValues.stringUnableToFindTemperature, "Error message shuld be: \(StringValues.stringUnableToFindTemperature)")
        })
    }
    
    func testGetForecastFailListKey(){
        mockWeatherService.withouthForecastListKey = true
        forecastViewModel = ForecastViewModel(weatherService: mockWeatherService)
        
        forecastViewModel.getForecast(withLocation: CLLocation(), onSuccess: { _ in},
                                      onFailure: { error in
                                        XCTAssertNotNil(error)
                                        XCTAssert(error.code == 404, "Error code should be 404")
                                        XCTAssert(error.message == StringValues.stringUnableToFindTemperature, "Error message shuld be: \(StringValues.stringUnableToFindTemperature)")
        })
    }
}
