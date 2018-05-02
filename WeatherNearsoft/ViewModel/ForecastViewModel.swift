//
//  ForecastViewModel.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 21/04/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import Foundation
import CoreLocation

struct ForecastViewModel {
    
    let weatherService = WeatherService()
    
    func getWeather(withLocation location : CLLocation, onSuccess: @escaping (_ forecastArray: [Forecast])-> Void, onFailure: @escaping(_ error : WeatherError)-> Void){
        weatherService.getForecast(withLocation: location, onSuccess: { (jsonObject) in
            
            guard let jsonForecastArray = jsonObject["list"] as? [[String : Any]] else {
                let error = WeatherError(code: 404, message: StringValues.stringUnableToFindTemperature)
                return onFailure(error)
            }
            
            //Getting the forecast array from the json response
            var forecastArray: [Forecast] = []
            for jsonForecast in jsonForecastArray {
                if let forecast = Forecast(jsonObject: jsonForecast) {
                    forecastArray.append(forecast)
                }
            }
            
            //Getting temperature average storing a forecast by day
            let forecastFound: [Forecast] = self.getForecastArrayWithAverageTemperatureByDay(withForecastArray: forecastArray)
            
            if forecastFound.count > 0 {
                onSuccess(forecastFound)
            }else {
                let error = WeatherError(code: 404, message: StringValues.stringUnableToFindTemperature)
                return onFailure(error)
            }
            
        }, onFailure: { (errorValue) in
            onFailure(errorValue)
        })
    }
    
    
    private func getForecastArrayWithAverageTemperatureByDay(withForecastArray forecastArray: [Forecast]) -> [Forecast] {
        var daysFound: [Int] = []
        var forecastFound: [Forecast] = []
        
        for var forecast in forecastArray {
            let day = Calendar.current.component(.weekday, from: forecast.date)

            if !daysFound.contains(day) && daysFound.count < 5 {
                let filteredArray = forecastArray.filter({(Calendar.current.component(.weekday, from: $0.date)) == day}) //Array by current day in for
                let maxTemperatureValues = filteredArray.map({$0.maxTemperature})
                let minTemperatureValues = filteredArray.map({$0.minTemperature})
                let maxTemperatureAverage = (maxTemperatureValues.reduce(0,+)/maxTemperatureValues.count)
                let minTemperatureAverage = (minTemperatureValues.reduce(0,+)/minTemperatureValues.count)
                
                forecast.maxTemperature = Int(maxTemperatureAverage)
                forecast.minTemperature = Int(minTemperatureAverage)
                
                if daysFound.count == 0 {
                    daysFound.append(day)
                    forecastFound.append(forecast)
                }else {
                    daysFound.append(day)
                    forecastFound.append(forecast)
                }
            }
        }
        
        return forecastFound
    }
}
