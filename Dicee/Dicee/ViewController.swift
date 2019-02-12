//
//  ViewController.swift
//  Dicee
//
//  Created by Felipe Del Canto Monge on 2/12/19.
//  Copyright © 2019 Felipe Del Canto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let diceArray = ["dice1", "dice2", "dice3", "dice4", "dice5", "dice6"]
    
    var randomDiceIndexLeft : Int = 0
    var randomDiceIndexRight : Int = 0
    
    @IBOutlet weak var diceImageViewLeft: UIImageView!
    @IBOutlet weak var diceImageViewRight: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func rollButtonPressed(_ sender: UIButton) {
        randomDiceIndexLeft = Int.random(in: 0 ... 5)
        randomDiceIndexRight = Int.random(in: 0 ... 5)
        
        print("Left random number:" + String(randomDiceIndexLeft))
        print("Right random number:" + String(randomDiceIndexRight))
        
        diceImageViewLeft.image = UIImage.init(named: diceArray[randomDiceIndexLeft])
        diceImageViewRight.image = UIImage.init(named: diceArray[randomDiceIndexRight])
    }

}

