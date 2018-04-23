//
//  DateConverter.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 21/04/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
class DateConverter {
    func getDayName(withStringDate stringDate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd H:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_GB")
        
        guard let date = dateFormatter.date(from: stringDate) else {
            return "Day not found"
        }
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        let time = timeFormatter.string(from: date)

        return "\(dateFormatter.weekdaySymbols[Calendar.current.component(.weekday, from: date)-1]) - \(time)"
    }
}
