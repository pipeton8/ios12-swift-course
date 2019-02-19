//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "f625b37137450bf1f272eabf39abd16d"

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    fileprivate func SetupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SetupLocationManager()
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    func GetWeatherData(url : String, parameters : [String : String]) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                self.UpdateWeatherData(JSON(response.result.value!))
                
            } else {
                print("Error \(response.result.error!)")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    func UpdateWeatherData(_ weatherData : JSON) {
        if let _ = weatherData["main"]["temp"].double {
            weatherDataModel.cityName = weatherData["name"].stringValue
            weatherDataModel.temperature = Int(weatherData["main"]["temp"].doubleValue - 273.15)
            weatherDataModel.condition = weatherData["weather"][0]["id"].intValue
            weatherDataModel.updateWeatherIcon()
            UpdateUIWithWeatherData()
        } else {
            cityLabel.text = "Weather Unavailable"
        }
    }

    //MARK: - UI Updates
    /***************************************************************/
    
    func UpdateUIWithWeatherData() {
        cityLabel.text = weatherDataModel.cityName
        temperatureLabel.text = "\(weatherDataModel.temperature)º"
        weatherIcon.image = UIImage.init(named: weatherDataModel.weatherConditionImage)
    }
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        if location.horizontalAccuracy <= 0.0 { return }
        locationManager.stopUpdatingLocation()
        
        let latitude : String = String(location.coordinate.latitude)
        let longitude : String = String(location.coordinate.longitude)
        let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]

        GetWeatherData(url : WEATHER_URL, parameters : params)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }
    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    

    
    //Write the PrepareForSegue Method here
    
    
}


