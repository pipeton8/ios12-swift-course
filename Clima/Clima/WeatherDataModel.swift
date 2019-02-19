//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Angela Yu on 24/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class WeatherDataModel {

    //Declare your model variables here
    var temperature : Int = 0
    var condition : Int = 0
    var cityName : String = ""
    var weatherConditionImage : String = ""
    
    //This method turns a condition code into the name of the weather condition image
    func updateWeatherIcon() {
        
    switch (condition) {
    
        case 0...300 :
            weatherConditionImage = "tstorm1"
        
        case 301...500 :
            weatherConditionImage = "light_rain"
        
        case 501...600 :
            weatherConditionImage = "shower3"
        
        case 601...700 :
            weatherConditionImage = "snow4"
        
        case 701...771 :
            weatherConditionImage = "fog"
        
        case 772...799 :
            weatherConditionImage = "tstorm3"
        
        case 800 :
            weatherConditionImage = "sunny"
        
        case 801...804 :
            weatherConditionImage = "cloudy2"
        
        case 900...903, 905...1000  :
            weatherConditionImage = "tstorm3"
        
        case 903 :
            weatherConditionImage = "snow5"
        
        case 904 :
            weatherConditionImage = "sunny"
        
        default :
            weatherConditionImage = "dunno"
        }
    }
}
