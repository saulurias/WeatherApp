//
//  JsonDataConverter.swift
//  WeatherNearsoft
//
//  Created by Saul Urias on 5/22/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation

class JsonDataConverter {
    func convertJsonDataToGenericResponse<T>(withData data: Data) -> T? {
        let jsonResult = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        return jsonResult as? T
    }
}
