//
//  DateConverter.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 21/04/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
class DateConverter {
    func getDayName(withDate date: Date) -> String {
        let dateFormatter = DateFormatter()      
        return "\(dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: date)-1])"
    }
}
