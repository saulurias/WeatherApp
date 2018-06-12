//
//  LocationMock.swift
//  WeatherNearsoftTests
//
//  Created by Saul Urias on 6/11/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation

//class MyPlacemark: CLPlacemark {}

//let placeMark = CLPlacemark(location: location,
//                            name: "Testing Name",
//                            postalAddress: nil)

class LocationMock: CLGeocoder {
    override func reverseGeocodeLocation(_ location: CLLocation, completionHandler: @escaping CLGeocodeCompletionHandler) {
        let placeMark = CLPlacemark()
        print(placeMark)
        completionHandler([placeMark], nil)
    }
}
