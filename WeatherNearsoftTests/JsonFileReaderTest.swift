//
//  JsonFileReaderTest.swift
//  WeatherNearsoftTests
//
//  Created by Saul Urias on 6/5/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit
import XCTest
@testable import WeatherNearsoft

class JsonFileReaderTest: XCTestCase {
    private let jsonFileReader = JsonFileReader()    
    
    func testReadFile(){
        XCTAssertNotNil(jsonFileReader.getJsonDataFromFile(withFileName: "WeatherJson"))
    }
    
    func testReadFileWithWrongFileName(){
        XCTAssertNil(jsonFileReader.getJsonDataFromFile(withFileName: "assd"))
    }    
}
