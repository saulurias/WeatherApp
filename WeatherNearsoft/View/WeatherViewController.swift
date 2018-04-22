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
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var constraintTopLabelTemp: NSLayoutConstraint!
    @IBOutlet weak var celciusLabel: UILabel!
    @IBOutlet weak var farenheitLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    //MARK: - Variables And Constants
    private var currentWeather : Weather?
    private var mustShowFahrenheit = true
    private let locationManager = CLLocationManager()
    private let weatherViewModel = WeatherViewModel()
    private let weatherConverter = WeatherConverter()
    private let segueToForecast = "segueToForecast"
    private var userLocation : CLLocation? = nil
    
    //MARK: - View Life
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLocationManager()
    }
    
    //MARK: - View Orientation
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        constraintTopLabelTemp.constant = UIDevice.current.orientation.isLandscape ? 50 : 100
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
    
    @IBAction func forecastButtonPressed(_ sender: Any) {
        if userLocation != nil {
            performSegue(withIdentifier: segueToForecast, sender: self)
        }else {
            self.modifyOutletValuesForErrorMessage(errorMessage: StringValues.stringUnableToFindForecast)
        }
    }
    
    //MARK: - Functions
    func getWeather(withUserLocation userLocation : CLLocation) {
        weatherViewModel.getWeather(withLocation: userLocation, onSuccess: { (weatherData) in
            self.currentWeather = weatherData
            self.getCityName(withUserLocation: userLocation)
            self.modifyOutletValuesToShowWeatherValues()
        }, onFailure: { error in
            self.modifyOutletValuesForErrorMessage(errorMessage: error.message)
        })
    }
    
    //FIXME: - Buscar solución lógica para la situación en la que no se encontro la ciudad
    func getCityName(withUserLocation location: CLLocation) {
        weatherViewModel.getCityName(byUserLocation: location, onSucces: { (city) in
            self.setLocationLabel(usingCityName: city)
        }, onFailure: { (error) in          
            self.setLocationLabel(usingCityName: error.message)
        })
    }
    
    func setLocationLabel(usingCityName city : String){
        let country = currentWeather?.countryName ?? "Country not found."
        locationLabel.text = "\(city), \(country)"
    }
    
    func setLocationLabelError(withErrorMessage errorMessage : String) {
        locationLabel.text = errorMessage
    }
    
    func modifyOutletValuesToShowWeatherValues(){
        //Printing Values
        DispatchQueue.main.async {
            if let weather = self.currentWeather {
                
                let maxTemperature = self.mustShowFahrenheit ? "\(weather.maxTemperature) ºF" : "\(self.weatherConverter.convertToCelsius(fromFarenheit: weather.maxTemperature)) ºC"
                let minTemperature = self.mustShowFahrenheit ? "\(weather.minTemperature) ºF" : "\(self.weatherConverter.convertToCelsius(fromFarenheit: weather.minTemperature)) ºC"
                let temperature = self.mustShowFahrenheit ? "\(weather.temperature) ºF" : "\(self.weatherConverter.convertToCelsius(fromFarenheit: weather.temperature)) ºC"
                
                self.maxTemperatureLabel.text = maxTemperature
                self.minTemperatureLabel.text = minTemperature
                self.temperatureLabel.text = temperature
                
                self.activityIndicator.stopAnimating()
            }else {
                self.modifyOutletValuesForErrorMessage(errorMessage: StringValues.stringUnableToFindTemperature)
            }
        }
    }
    
    func modifyOutletValuesForErrorMessage(errorMessage : String){
        DispatchQueue.main.async {
            self.temperatureLabel.text = errorMessage
            self.maxTemperatureLabel.text = ""
            self.minTemperatureLabel.text = ""
            self.locationLabel.text = ""
            self.celciusLabel.text = ""
            self.farenheitLabel.text = ""
            self.switchButton.isHidden = true
            self.switchButton.isEnabled = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    func modifyOutletValuesForLoadingView(){
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.temperatureLabel.text = ""
            self.maxTemperatureLabel.text = "---"
            self.minTemperatureLabel.text = "---"
            self.locationLabel.text = "---"
            self.celciusLabel.text = "Celcius"
            self.farenheitLabel.text = "Fahrenheit"
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
        temperatureLabel.text = StringValues.stringLocationAuthorizationNeeded
    }
    
    func setupLocationManager(){
        //Request when the App is open
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
    }
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToForecast {
            if let location = userLocation {
                let forecastViewController = segue.destination as! ForecastViewController
                forecastViewController.userLocation = location
                forecastViewController.mustShowFahrenheit = mustShowFahrenheit
            }else {
                modifyOutletValuesForErrorMessage(errorMessage: StringValues.stringUnableToFindForecast)
            }
        }
    }
}

//MARK: - CLLocation Manager Delegate
extension WeatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            modifyOutletValuesForLoadingView()
            userLocation = location
            getWeather(withUserLocation : userLocation!)
        }else {
            modifyOutletValuesForErrorMessage(errorMessage: StringValues.stringLocationAccessError)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied){
            currentWeather = nil
            modifyOutletValuesForLoadingView()
            showLocationDisabledAlert()
            setLabelLocationAthorizationNeeded()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        modifyOutletValuesForErrorMessage(errorMessage: StringValues.stringLocationAccessError)
    }
}
