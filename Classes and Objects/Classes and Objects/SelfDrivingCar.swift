//
//  SelfDrivingCar.swift
//  Classes and Objects
//
//  Created by Felipe Del Canto Monge on 2/15/19.
//  Copyright © 2019 Felipe Del Canto. All rights reserved.
//

import Foundation

class SelfDrivingCar : Car {
    
    var destination : String?
    
    override func drive() {
        super.drive()
        if let userSetDestination = destination {
            print("Driving to " + userSetDestination)
        }
    }
    
    func goToDestination(_ newDestination : String) {
        destination = newDestination
        drive()
    }
}
