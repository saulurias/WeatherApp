//
//  ForecastViewController.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 21/04/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController {
    //MARK: - View Life
    @IBOutlet weak var forecastTableView: UITableView!
    
    //MARK: - Variables And Constants
    private let forecastViewModel = ForecastViewModel()
    private let dateConverter = DateConverter()
    private let weatherConverter = WeatherConverter()
    private var forecastArray = [Forecast]()
    var userLocation: CLLocation? = nil
    var mustShowFahrenheit = true
    
    //MARK: - View Life
    override func viewDidLoad() {
        super.viewDidLoad()
        setupForecastTableView()
        
        if userLocation != nil {
            getForecast()
        }
    }
    
    //MARK: - Functions
    func setupForecastTableView(){
        forecastTableView.dataSource = self
    }
    
    func getForecast(){
        forecastViewModel.getWeather(withLocation: userLocation!, onSuccess: { (forecastData) in
            self.forecastArray = forecastData
            DispatchQueue.main.async {
                self.forecastTableView.reloadData()
            }
        }, onFailure: { error in
            
        })
    }
}

//MARK: - TableView DataSource
extension ForecastViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let forecastCell = Bundle.main.loadNibNamed("ForecastTableViewCell", owner: self, options: nil)?.first as! ForecastTableViewCell
        
        let forecast = forecastArray[indexPath.row]
        
        let maxTemperature = self.mustShowFahrenheit ? "\(forecast.maxTemperature) ºF" : "\(self.weatherConverter.convertToCelsius(fromFarenheit: forecast.maxTemperature)) ºC"
        let minTemperature = self.mustShowFahrenheit ? "\(forecast.minTemperature) ºF" : "\(self.weatherConverter.convertToCelsius(fromFarenheit: forecast.minTemperature)) ºC"
        
        forecastCell.dayLabelName.text = "\(dateConverter.getDayName(withStringDate: forecast.date))"
        forecastCell.temperatureLabel.text = "\(maxTemperature) / \(minTemperature)"
        
        return forecastCell
    }
}
