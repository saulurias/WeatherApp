//
//  ModelForecastTest.swift
//  WeatherNearsoftTests
//
//  Created by Saul Urias on 5/18/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import XCTest
@testable import WeatherNearsoft

class ModelForecastTest: XCTestCase {
    private var jsonObject: [String: Any] = [:]
    private var mainDictionary: [String: Any] = [:]
    private let jsonFileReader = JsonFileReader()
    private let jsonDataConverter = JsonDataConverter()
    
    override func setUp() {
        super.setUp()
        if let data = jsonFileReader.getJsonDataFromFile(withFileName: "ForecastModelJson") {
            jsonObject = jsonDataConverter.convertJsonDataToGenericResponse(withData: data)!
            mainDictionary = jsonObject["main"] as! [String: Any]
        }
    }
    
    func testWeatherInit() {
        let forecatObject = Forecast(jsonObject: jsonObject)
        XCTAssertNotNil(forecatObject)
    }
    
    func testWeatherInitNilIcon() {
        var weather = jsonObject["weather"] as! [String: Any]
        weather["weather"] = nil
        jsonObject["weather"] = weather
        let forecatObject = Forecast(jsonObject: jsonObject)
        let result = forecatObject?.urlIcon
        let expected = ""
        XCTAssert(result == expected)
    }
    
    func testModelInitWithNilMain() {
        jsonObject["main"] = nil
        let forecatObject = Forecast(jsonObject: jsonObject)
        XCTAssertNil(forecatObject)
    }
    
    func testModelInitWithWrongDate() {
        jsonObject["dt_txt"] = "asd"
        let forecatObject = Forecast(jsonObject: jsonObject)
        XCTAssertNil(forecatObject)
    }
    
    func testModelInitWithNilDate() {
        jsonObject["dt_txt"] = nil
        let forecatObject = Forecast(jsonObject: jsonObject)
        XCTAssertNil(forecatObject)
    }
    
    func testModelInitWithNilTempMax() {
        mainDictionary["temp_max"] = nil
        jsonObject["main"] = mainDictionary
        let forecatObject = Forecast(jsonObject: jsonObject)
        XCTAssertNil(forecatObject)
    }

    func testModelInitWithNilTempMin() {
        mainDictionary["temp_min"] = nil
        jsonObject["main"] = mainDictionary
        let forecatObject = Forecast(jsonObject: jsonObject)
        XCTAssertNil(forecatObject)
    }
}
