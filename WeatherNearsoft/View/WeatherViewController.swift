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
            modifyOutletsForLoadingView()
            showLocationDisabledPopUp()
            setLabelLocationAthorizationNeeded()
        }
    }
    
    //MARK: - Actions
    @IBAction func buttonRefreshPressed(_ sender: Any) {
        if WeatherViewModel.locationAuthorized() {
            locationManager.startUpdatingLocation()
            modifyOutletsForLoadingView()
        }else {
            showLocationDisabledPopUp()
        }
    }
    
    @IBAction func switchPressed(_ sender: Any) {
        if mustShowFahrenheit == true {
            mustShowFahrenheit = false
        }else {
            mustShowFahrenheit = true
        }
        showWeatherValues()
    }
    
    
    //MARK: - Functions
    func getWeather(withUserLocation userLocation : CLLocation) {
        WeatherViewModel.getWeather(withLocation: userLocation, onSuccess: { (weatherValues) in
            self.currentWeather = weatherValues
            self.getCityName(withUserLocation: userLocation)
            self.showWeatherValues()
        }, onFailure: { errorMessage in
            self.modifyOutletsForErrorMessage(errorMessage: errorMessage)
        })
    }
    
    func setLocationLabel(usingCityName city : String){
        let country = currentWeather?.countryName ?? ""
        labelLocation.text = "\(city), \(country)"
    }
    
    func setLocationLabelError(withErrorMessage errorMessage : String) {
        labelLocation.text = errorMessage
    }
    
    func getCityName(withUserLocation location: CLLocation) {
        WeatherViewModel.getCityName(byUserLocation: location, onSucces: { (city) in
            self.setLocationLabel(usingCityName: city)
        }) { (errorMessage) in
            self.setLocationLabelError(withErrorMessage: errorMessage)
        }
    }
    
    func showWeatherValues(){
        //Printing Values
        DispatchQueue.main.async {
            if let weather = self.currentWeather {
                if self.mustShowFahrenheit {
                    self.labelMaxTemp.text = "Max: \(weather.maxTemp) ºF"
                    self.labelMinTemp.text = "Min: \(weather.minTemp) ºF"
                    self.labelTemp.text = "\(weather.temp) ºF"
                }else {
                    self.labelMaxTemp.text = "Max: \(WeatherConverter.convertToCelsius(fromFarenheit: weather.maxTemp)) ºC"
                    self.labelMinTemp.text = "Min: \(WeatherConverter.convertToCelsius(fromFarenheit: weather.minTemp)) ºC"
                    self.labelTemp.text = "\(WeatherConverter.convertToCelsius(fromFarenheit: weather.temp)) ºC"
                }
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func modifyOutletsForErrorMessage(errorMessage : String){
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
    
    func modifyOutletsForLoadingView(){
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
    
    func showLocationDisabledPopUp(){
        let alertController = UIAlertController(title: "Location Access Disables", message: "Location its needed to get the weather", preferredStyle: .alert)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func setLabelLocationAthorizationNeeded(){
        labelTemp.text = "Location Authorization Needed"
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
            modifyOutletsForLoadingView()
            getWeather(withUserLocation : location)
        }
    }
}
