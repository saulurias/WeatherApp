//
//  DateConverterTest.swift
//  WeatherNearsoftTests
//
//  Created by Saul Urias on 5/17/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import XCTest
@testable import WeatherNearsoft

class DateConverterTests: XCTestCase {
    private let dateConverter = DateConverter()
    private let dateFormatter = DateFormatter()
    
    func testGetDayName(){
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateTest = dateFormatter.date(from: "2018-05-17")!
        let result = dateConverter.getDayName(withDate: dateTest)
        let expected = "Thursday"
        XCTAssert(result == expected)
    }
}
