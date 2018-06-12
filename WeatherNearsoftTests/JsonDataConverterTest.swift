//
//  JsonDataConverterTest.swift
//  WeatherNearsoftTests
//
//  Created by Saul Urias on 6/5/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation
import XCTest
@testable import WeatherNearsoft

class JsonDataConverterTest: XCTestCase {
    private let jsonDataConverter = JsonDataConverter()
    private let jsonFileReader = JsonFileReader()
    
    func testConvertJsonDataToGenericResponse(){
        XCTAssertNotNil(jsonFileReader.getJsonDataFromFile(withFileName: "ForecastModelJson"))
    }        
    
    func testConvertJsonDataToGenericResponseFail(){
        XCTAssertNil(jsonDataConverter.convertJsonDataToGenericResponse(withData: Data()))
    }
}
