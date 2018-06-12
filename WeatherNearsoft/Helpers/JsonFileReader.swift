//
//  JsonFileReader.swift
//  WeatherNearsoft
//
//  Created by Saul Urias on 5/22/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation

protocol JsonFileReaderProtocol {
    func getJsonDataFromFile(withFileName fileName: String) -> Data?
}

class JsonFileReader: JsonFileReaderProtocol {
    func getJsonDataFromFile(withFileName fileName: String) -> Data? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            return nil
        }
        
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
}
