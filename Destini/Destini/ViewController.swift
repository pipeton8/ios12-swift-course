//
//  ViewController.swift
//  Destini
//
//  Created by Philipp Muellauer on 01/09/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // UI Elements linked to the storyboard
    @IBOutlet weak var topButton: UIButton!     // tag = 1
    @IBOutlet weak var bottomButton: UIButton!  // tag = 2
    @IBOutlet weak var storyTextView: UILabel!
    
    let storyLine = StoryLine()
    var currentStory : Story!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NextStory(index : 0)
    }

    // User presses one of the buttons
    @IBAction func buttonPressed(_ sender: UIButton) {
        if currentStory.isFinal {
            StartOver()
        } else {
            let answerIndex = sender.tag - 1
            NextStory(index: currentStory.consequences[answerIndex])
        }
    }
    
    func NextStory(index storyIndex : Int) {
        currentStory = storyLine.stories[storyIndex]
        SetStoryText()
        SetButtonsText()
    }

    func SetStoryText() {
        storyTextView.text = currentStory.text
    }
    
    func SetButtonsText() {
        if !currentStory.isFinal {
            topButton.setTitle(currentStory.answers[0], for: .normal)
            bottomButton.setTitle(currentStory.answers[1], for: .normal)
        } else {
            topButton.setTitle("Start Over", for: .normal)
            bottomButton.isHidden = true
        }
    }
    
    func StartOver() {
        bottomButton.isHidden = false
        NextStory(index: 0)
    }


}

