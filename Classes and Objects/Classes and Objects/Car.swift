//
//  Car.swift
//  Classes and Objects
//
//  Created by Felipe Del Canto Monge on 2/15/19.
//  Copyright © 2019 Felipe Del Canto. All rights reserved.
//

import Foundation

enum CarType {
    case Sedan
    case Coupe
    case Hatchback
}

class Car {
    var color : String = "Red"
    var numberOfSeats : Int = 5
    var carType : CarType = .Coupe
    
    init() { }
    
    convenience init(color customColor: String, numberOfSeats: Int, carType: CarType) {
        self.init()
        self.color = customColor
        self.numberOfSeats = numberOfSeats
        self.carType = carType
    }
    
    func drive() {
        print("Car started moving")
    }
}
