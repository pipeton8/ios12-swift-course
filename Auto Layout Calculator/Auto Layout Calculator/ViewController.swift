//
//  ViewController.swift
//  Auto Layout Calculator
//
//  Created by Felipe Del Canto Monge on 2/15/19.
//  Copyright © 2019 Felipe Del Canto. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!

    let maxNumbersOnScreen : Int = 8
    
    var partialResult : Float = 0
    var screenText : String = "0"
    var waitingForSecondNumber : Bool = false
    var deleteAll : Bool = true
    var dotPressed : Bool = false
    var currentOperationTag : Int = 0
    var lastSecondNumber : Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UpdateUI()
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        let totalNumbersOnScreen = screenText.count - Int(truncating: NSNumber(value:dotPressed))
        if totalNumbersOnScreen < maxNumbersOnScreen {
            if screenText == "0" && sender.tag != 0 {
                screenText = "\(sender.tag)"
                deleteAll = false
            }
            else { screenText += "\(sender.tag)" }
            UpdateUI()
        }
    }
    
    @IBAction func operationPressed(_ sender: UIButton) {
        if !waitingForSecondNumber {
            partialResult = Float(screenText)!
        } else {
            CalculateResult()
            screenText = FormatToString(partialResult)
        }
        
        UpdateUI()
        waitingForSecondNumber = true
        screenText = "0"
        currentOperationTag = sender.tag
    }
    
    @IBAction func equalPressed(_ sender: UIButton) {
        if waitingForSecondNumber {
            lastSecondNumber = Float(screenText)!
        }
        CalculateResult()
        waitingForSecondNumber = false
        dotPressed = false
        screenText = FormatToString(partialResult)
        UpdateUI()
    }
    
    @IBAction func changeSignPressed(_ sender: UIButton) {
        if screenText.first == "-" {
            screenText.removeFirst()
        } else {
            screenText = "-" + screenText
        }
        UpdateUI()
    }
    
    @IBAction func dotPressed(_ sender: UIButton) {
        if !dotPressed {
            screenText += "."
            dotPressed = true
            deleteAll = false
            UpdateUI()
        }
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        if deleteAll {
            partialResult = 0
        } else { deleteAll = true }
        screenText = "0"
        dotPressed = false
        UpdateUI()
    }
    
    @IBAction func percentagePressed(_ sender: UIButton) {
        var newNumber = Float(screenText)!
        newNumber /= 100
        screenText = FormatToString(newNumber)
        lastSecondNumber = newNumber
        UpdateUI()
    }
    
    fileprivate func CalculateResult() {
        lastSecondNumber = Float(screenText)!
        /*  tag 0 is +
         tag 1 is -
         tag 2 is *
         tag 3 is ÷
         */
        if currentOperationTag == 0 {
            partialResult += lastSecondNumber
        } else if currentOperationTag == 1 {
            partialResult -= lastSecondNumber
        } else if currentOperationTag == 2 {
            partialResult *= lastSecondNumber
        } else if currentOperationTag == 3 {
            partialResult /= lastSecondNumber
        }
    }
    
    fileprivate func FormatToString(_ number : Float) -> String {
        let isInt : Bool = floor(number) == number
        var text : String = String(number)
        if isInt && text.count <= maxNumbersOnScreen + 2 {
            text.removeLast(2)
        }
        return text
    }
    
    fileprivate func UpdateUI() {
        if deleteAll { deleteButton.setTitle("AC", for: .normal)}
        else { deleteButton.setTitle("C", for: .normal) }
        resultLabel.text = screenText
    }
    
}

