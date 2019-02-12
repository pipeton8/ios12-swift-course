//
//  ViewController.swift
//  Magic 8 Ball
//
//  Created by Felipe Del Canto Monge on 2/12/19.
//  Copyright © 2019 Felipe Del Canto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let answersArray = ["ball1", "ball2", "ball3", "ball4", "ball5"]
    
    @IBOutlet weak var ballImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ShowAnswer()
    }

    @IBAction func askButtonPressed(_ sender: Any) {
        ShowAnswer()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        ShowAnswer()
    }
    
    func ShowAnswer() {
        let newAnswerIndex = Int.random(in: 0 ... 4)
        
        ballImageView.image = UIImage.init(named: answersArray[newAnswerIndex])
        
    }

}

