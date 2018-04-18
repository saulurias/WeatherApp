//
//  ViewController.swift
//  WeatherNearsoft
//
//  Created by saul ulises urias guzmàn on 26/03/18.
//  Copyright © 2018 saul ulises urias guzmàn. All rights reserved.
//

import UIKit
import CoreLocation
import SystemConfiguration

class WeatherViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var labelMaxTemp: UILabel!
    @IBOutlet weak var labelMinTemp: UILabel!
    @IBOutlet weak var labelTemp: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var buttonRefresh: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var constraintTopLabelTemp: NSLayoutConstraint!
    @IBOutlet weak var labelCelcius: UILabel!
    @IBOutlet weak var labelFarenheit: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    //MARK: - Varailabels And Constants
    var currentWeather : Weather?
    var mustShowFahrenheit = true
    let locationManager = CLLocationManager()
    let weatherViewModel = WeatherViewModel()
    
    //MARK: - View Life
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
    }
    
    //MARK: - View Orientation
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        constraintTopLabelTemp.constant = UIDevice.current.orientation.isLandscape ? 50 : 100
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied){
            currentWeather = nil
            modifyOutletValuesForLoadingView()
            showLocationDisabledAlert()
            setLabelLocationAthorizationNeeded()
        }
    }
    
    //MARK: - Actions
    @IBAction func buttonRefreshPressed(_ sender: Any) {
        if weatherViewModel.locationAuthorized() {
            locationManager.startUpdatingLocation()
            modifyOutletValuesForLoadingView()
        }else {
            showLocationDisabledAlert()
        }
    }
    
    @IBAction func switchPressed(_ sender: Any) {
        if mustShowFahrenheit == true {
            mustShowFahrenheit = false
        }else {
            mustShowFahrenheit = true
        }
        modifyOutletValuesToShowWeatherValues()
    }
    
    
    //MARK: - Functions
    func getWeather(withUserLocation userLocation : CLLocation) {
        weatherViewModel.getWeather(withLocation: userLocation, onSuccess: { (weatherValues) in
            self.currentWeather = weatherValues
            self.getCityName(withUserLocation: userLocation)
            self.modifyOutletValuesToShowWeatherValues()
        }, onFailure: { error in
            self.modifyOutletValuesForErrorMessage(errorMessage: error.message)
        })
    }
    
    func getCityName(withUserLocation location: CLLocation) {
        weatherViewModel.getCityName(byUserLocation: location, onSucces: { (city) in
            self.setLocationLabel(usingCityName: city)
        }) { (error) in
            self.setLocationLabelError(withErrorMessage: error.message)
        }
    }
    
    func setLocationLabel(usingCityName city : String){
        let country = currentWeather?.countryName ?? ""
        labelLocation.text = "\(city), \(country)"
    }
    
    func setLocationLabelError(withErrorMessage errorMessage : String) {
        labelLocation.text = errorMessage
    }
    
    func modifyOutletValuesToShowWeatherValues(){
        //Printing Values
        DispatchQueue.main.async {
            if let weather = self.currentWeather {
                if self.mustShowFahrenheit {
                    self.labelMaxTemp.text = "Max: \(weather.maxTemperature) ºF"
                    self.labelMinTemp.text = "Min: \(weather.minTemperature) ºF"
                    self.labelTemp.text = "\(weather.temperature) ºF"
                }else {
                    self.labelMaxTemp.text = "Max: \(WeatherConverter.convertToCelsius(fromFarenheit: weather.maxTemperature)) ºC"
                    self.labelMinTemp.text = "Min: \(WeatherConverter.convertToCelsius(fromFarenheit: weather.minTemperature)) ºC"
                    self.labelTemp.text = "\(WeatherConverter.convertToCelsius(fromFarenheit: weather.temperature)) ºC"
                }
                self.activityIndicator.stopAnimating()
            }else {
                self.modifyOutletValuesForErrorMessage(errorMessage: StringValues.stringUnableToFindTemperature)
            }
        }
    }
    
    func modifyOutletValuesForErrorMessage(errorMessage : String){
        DispatchQueue.main.async {
            self.labelTemp.text = errorMessage
            self.labelMaxTemp.text = ""
            self.labelMinTemp.text = ""
            self.labelLocation.text = ""
            self.labelCelcius.text = ""
            self.labelFarenheit.text = ""
            self.switchButton.isHidden = true
            self.switchButton.isEnabled = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func modifyOutletValuesForLoadingView(){
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.labelTemp.text = ""
            self.labelMaxTemp.text = "---"
            self.labelMinTemp.text = "---"
            self.labelLocation.text = "---"
            self.labelCelcius.text = "Celcius"
            self.labelFarenheit.text = "Fahrenheit"
            self.switchButton.isHidden = false
            self.switchButton.isEnabled = true
        }
    }
    
    func showLocationDisabledAlert() {
        let alertController = UIAlertController(title: StringValues.stringLocationAccessDisabled, message: StringValues.stringLocationAuthorizationNeeded, preferredStyle: .alert)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setLabelLocationAthorizationNeeded(){
        labelTemp.text = StringValues.stringLocationAuthorizationNeeded
    }
    
}
//MARK: - CLLocation Manager Delegate
extension WeatherViewController : CLLocationManagerDelegate {
    func setupLocationManager(){
        //Request when the App is open
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            modifyOutletValuesForLoadingView()
            getWeather(withUserLocation : location)
        }
    }
}
