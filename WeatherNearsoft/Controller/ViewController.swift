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


class ViewController: UIViewController, CLLocationManagerDelegate {
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
        self.setupLocationManager()
    }

    //MARK: - View Orientation
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            self.constraintTopLabelTemp.constant = 50
        }else {
            self.constraintTopLabelTemp.constant = 100
        }
    }
    
    //MARK: - CLLocation Manager Delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.locationManager.stopUpdatingLocation()
            self.getWeather(userLocation : location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied){
            self.currentWeather = nil
            self.startLoading()
            self.showLocationDisabledPopUp()
        }
    }
    
    //MARK: - Actions
    @IBAction func buttonRefreshPressed(_ sender: Any) {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            self.locationManager.startUpdatingLocation()
            self.startLoading()
        }else {
            self.currentWeather = nil
            self.startLoading()
            self.showLocationDisabledPopUp()
        }
    }
    
    @IBAction func switchPressed(_ sender: Any) {
        if self.mustShowFahrenheit == true {
            self.mustShowFahrenheit = false
        }else {
            self.mustShowFahrenheit = true
        }
        self.showWeatherValues()
    }
    
    
    //MARK: - Functions
    func setupLocationManager(){
        //Request when the App is open
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    func getWeather(userLocation : CLLocation) {
        if self.isInternetAvailable() {
            self.startLoading()
            WebService.getWeather(location : userLocation) { (status, message, weather) in
                if status {
                    if let weatherValues = weather {
                        self.currentWeather = weatherValues
                        self.getCityName(userLocation: userLocation)
                        self.showWeatherValues()
                        self.locationManager.stopUpdatingLocation()
                    }else {
                        self.showError(errorMessage: message)
                    }
                }else {
                    self.locationManager.startUpdatingLocation()
                }
            }
        }else {
            self.locationManager.stopUpdatingLocation()
            self.showError(errorMessage: "No Internet Connection")
        }
    }
    
    func getCityName(userLocation : CLLocation){
        CLGeocoder().reverseGeocodeLocation(userLocation) { (placemark, error) in
            if error != nil {
                self.labelLocation.text = "Error getting location"
            }else {
                if let place = placemark?.first {
                    let city = place.locality ?? ""
                    if let weather = self.currentWeather {
                        self.labelLocation.text = "\(city), \(weather.countryName)"
                    }
                }
            }
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
                    self.labelMaxTemp.text = "Max: \(self.convertToCelsius(fahrenheit: weather.maxTemp)) ºC"
                    self.labelMinTemp.text = "Min: \(self.convertToCelsius(fahrenheit: weather.minTemp)) ºC"
                    self.labelTemp.text = "\(self.convertToCelsius(fahrenheit: weather.temp)) ºC"
                }
                
                self.activityIndicator.stopAnimating()
            }
        }
    }
    
    func showError(errorMessage : String){
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
    
    func startLoading(){
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
    
    func convertToCelsius(fahrenheit: Double) -> Double {
        let divisor = pow(10.0, Double(2))
        let celcius = 5.0 / 9.0 * (Double(fahrenheit) - 32.0) //Converting from Farenheit to Celcius
        return ((celcius * divisor).rounded() / divisor) //Rounding to two decimals
    }
    
    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    func showLocationDisabledPopUp(){
        self.labelTemp.text = "Location Authorization Needed"
        self.activityIndicator.stopAnimating()
        let alertController = UIAlertController(title: "Location Access Disables", message: "Location its needed to get the weather", preferredStyle: .alert)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string: UIApplicationOpenSettingsURLString) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        alertController.addAction(openAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}
