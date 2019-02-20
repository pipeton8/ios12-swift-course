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

class WeatherViewController: UIViewController, CLLocationManagerDelegate, ChangeCityDelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "f625b37137450bf1f272eabf39abd16d"
    let DUNNO_ID = -1

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let weatherDataModel = WeatherDataModel()
    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    @IBAction func refreshButton(_ sender: Any) {
        locationManager.startUpdatingLocation()
    }
    
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
                self.RefreshWeather(JSON(response.result.value!))
                
            } else {
                print("Error \(response.result.error!)")
                self.cityLabel.text = "Connection Issues"
            }
        }
    }
    
    //MARK: - JSON Parsing
    fileprivate func UpdateWeatherModel(with weatherData: JSON) {
        weatherDataModel.cityName = weatherData["name"].stringValue
        weatherDataModel.temperature = Int(weatherData["main"]["temp"].doubleValue - 273.15)
        weatherDataModel.condition = weatherData["weather"][0]["id"].intValue
        weatherDataModel.updateWeatherIcon()
    }
    
    /***************************************************************/
   
    func RefreshWeather(_ weatherData : JSON) {
        if let _ = weatherData["main"]["temp"].double {
            UpdateWeatherModel(with : weatherData)
        } else {
            weatherDataModel.cityName = "Weather Unavailable"
            weatherDataModel.temperature = 0
            weatherDataModel.condition = DUNNO_ID
            weatherDataModel.updateWeatherIcon()
        }
        UpdateUI()
    }

    //MARK: - UI Updates
    /***************************************************************/
    
    func UpdateUI() {
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
    func UserEnteredNewCity(city: String) {
        let params : [String : String] = ["q" : city , "appid" : APP_ID]
        
        GetWeatherData(url: WEATHER_URL, parameters: params)
    }
    
    fileprivate func SetChangeCityDelegate(_ segue: UIStoryboardSegue) {
        if segue.identifier == "changeCityName" {
            let destinationVC = segue.destination as! ChangeCityViewController
            destinationVC.delegate = self
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        SetChangeCityDelegate(segue)
    }
}


