//
//  ModelWeatherTest.swift
//  WeatherNearsoftTests
//
//  Created by Saul Urias on 5/17/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import XCTest
@testable import WeatherNearsoft

class ModelWeatherTest: XCTestCase {
    
    private var jsonObject: [String: Any] = [:]
    private var mainDictionary: [String: Any] = [:]
    private let jsonFileReader = JsonFileReader()
    private let jsonDataConverter = JsonDataConverter()
    
    override func setUp() {
        super.setUp()
        if let data = jsonFileReader.getJsonDataFromFile(withFileName: "WeatherJson") {
            jsonObject = jsonDataConverter.convertJsonDataToGenericResponse(withData: data)!
            mainDictionary = jsonObject["main"] as! [String: Any]
        }
    }
    
    func testWeatherInit() {
        let weatherObject = Weather(jsonObject: jsonObject)
        XCTAssertNotNil(weatherObject)
    }
    
    func testModelInitWithNilMain() {
        jsonObject["main"] = nil
        let wheaterObject = Weather(jsonObject: jsonObject)
        XCTAssertNil(wheaterObject)
    }
    
    func testModelInitWithNilCountry() {
        var sys = jsonObject["sys"] as! [String: Any]
        sys["country"] = nil
        jsonObject["sys"] = sys
        let wheaterObject = Weather(jsonObject: jsonObject)
        let result = wheaterObject?.countryName
        let expected = "Country not found."
        XCTAssert(result == expected)
    }

    func testModelInitWithNilSys() {        
        jsonObject["sys"] = nil
        let wheaterObject = Weather(jsonObject: jsonObject)
        let result = wheaterObject?.countryName
        let expected = "Country not found."
        XCTAssert(result == expected)
    }
    
    func testModelInitWithNilTempMax() {
        mainDictionary["temp_max"] = nil
        jsonObject["main"] = mainDictionary
        let wheaterObject = Weather(jsonObject: jsonObject)
        XCTAssertNil(wheaterObject)
    }

    func testModelInitWithNilTempMin() {
        mainDictionary["temp_min"] = nil
        jsonObject["main"] = mainDictionary
        let wheaterObject = Weather(jsonObject: jsonObject)
        XCTAssertNil(wheaterObject)
    }

    func testModelInitWithNilTemp() {
        mainDictionary["temp"] = nil
        jsonObject["main"] = mainDictionary
        let wheaterObject = Weather(jsonObject: jsonObject)
        XCTAssertNil(wheaterObject)
    }
}
