//
//  HMStubs.swift
//  WeatherNearsoft
//
//  Created by Saul Urias on 6/12/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import OHHTTPStubs

enum HMTestFile: String {
    case weatherFile = "WeatherJson.json"
}

class HMStubs {
    private var bundle: Bundle!
    static private let defaultHeaders: [String: Any] = ["Content-Type": "application/json"]
    
    init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    func createStubs(fromFile file: HMTestFile, withStatusCode statusCode: Int32, forPaths paths: [String], headers: [String: Any] = defaultHeaders) {
        guard let conditions = conditions(forPaths: paths) else {
            return
        }
        
        stub(condition: conditions) { _ in
            print(file.rawValue)
            guard let stubPath = OHPathForFileInBundle(file.rawValue, self.bundle) else {
                preconditionFailure("Could not find expected file in test bundle")
            }
            return OHHTTPStubsResponse(fileAtPath: stubPath, statusCode: statusCode, headers: headers)
        }
    }
    
    func createEmptyStub(statusCode: Int32, forPaths paths: [String], headers: [String: Any] = defaultHeaders) {
        guard let conditions = conditions(forPaths: paths) else {
            return
        }
        stub(condition: conditions) { _ in
            let stubEmptyData = "".data(using: .utf8)!
            return OHHTTPStubsResponse(data: stubEmptyData, statusCode: statusCode, headers: headers)
        }
    }
    
    func removeStubs() {
        OHHTTPStubs.removeAllStubs()
    }
    
    private func conditions(forPaths paths: [String]) -> OHHTTPStubsTestBlock? {
        var test: OHHTTPStubsTestBlock?
        guard let firstPath = paths.first else {
            return nil
        }
        
        test = isPath(firstPath)
        
        for path in paths {
            guard let prevTest = test else {
                return nil
            }
            test = prevTest || isPath(path)
        }
        return test
    }
}
