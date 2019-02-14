//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 27/01/2016.
//  Copyright © 2016 London App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    var audioPlayer : AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    fileprivate func PlayNote(_ noteName: String) {
        do {
            let noteSound = Bundle.main.url(forResource: noteName, withExtension : "wav")!
            audioPlayer = try AVAudioPlayer(contentsOf: noteSound)
            audioPlayer.play()
        } catch { print("There is an issue with this code!") }
    }
    
    @IBAction func notePressed(_ sender: UIButton) {
        PlayNote("note\(sender.tag)")
    }
}

