//
//  ImageViewExtenstionsTest.swift
//  WeatherNearsoftTests
//
//  Created by Saul Urias on 6/5/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation
import XCTest
@testable import WeatherNearsoft

class ImageViewExtensionsTest: XCTestCase {
    private let downloadImageExpectation = XCTestExpectation(description: "Downloaded Icon")
    
    func testImageView(){
        let imageView = UIImageView()
        imageView.downloadIcon(withUrlIconString: "https://openweathermap.org/img/w/01n.png") { _ in
            XCTAssertNotNil(imageView.image)
            self.downloadImageExpectation.fulfill()
        }
        wait(for: [downloadImageExpectation], timeout: 15.0)
    }
}
