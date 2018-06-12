//
//  WeatherNearsoftTests.swift
//  WeatherNearsoftTests
//
//  Created by Saul Urias on 5/17/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import XCTest
@testable import WeatherNearsoft

class WeatherConverterTests: XCTestCase {
    
    private let weatherConverter = WeatherConverter()
    
    func testConvertToCelsius(){
        let result = weatherConverter.convertToCelsius(fromFarenheit: 32)
        let expected = 0        
        XCTAssert(result == expected)
    }
}
