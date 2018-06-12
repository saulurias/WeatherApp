//
//  LocationViewModelTest.swift
//  WeatherNearsoftTests
//
//  Created by Saul Urias on 6/5/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation
import XCTest
@testable import WeatherNearsoft

class LocationViewModelTest: XCTestCase {
    private let locationMock = LocationMock()
    private let locationExpectation = XCTestExpectation(description: "Found City Name")
    private var locationViewModel : LocationViewModel!
    
    override func setUp() {
        super.setUp()
        locationViewModel = LocationViewModel()
    }

    func testGetCityName(){
        let location = CLLocation(latitude: 29.1026, longitude: -110.97732)        
        locationViewModel.getCityName(byUserLocation: location, onSucces: { cityNameFound in
            let expected = "Hermosillo"
            XCTAssert(expected == cityNameFound)
            self.locationExpectation.fulfill()
        }, onFailure: {_ in })
        
        wait(for: [locationExpectation], timeout: 10.0)        
    }
    
    func testGetCityNameError(){
        let location = CLLocation(latitude: 0, longitude: 0)
        locationViewModel.getCityName(byUserLocation: location, onSucces: {_ in },
        onFailure: { (error) in
            XCTAssertNotNil(error)
            XCTAssert(error.code == 404)
            XCTAssert(error.message == "City not found")
            self.locationExpectation.fulfill()
        })
        
        wait(for: [locationExpectation], timeout: 10.0)
    }
    
    func testLocationAuthorized(){
        XCTAssert(locationViewModel.isLocationAuthorized())        
    }
    
    
    
    
}
