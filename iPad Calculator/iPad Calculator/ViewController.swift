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
    let whiteColor = UIColor.white
    let orangeColor = UIColor.init(red: 1, green: 0.58, blue: 0, alpha: 1)
    
    var partialResult : Float = 0
    var screenText : String = "0"
    var waitingForSecondNumber : Bool = false
    var deleteAll : Bool = true
    var dotPressed : Bool = false
    var showingResult : Bool = false
    var lastOperationPressed : UIButton?
    var lastSecondNumber : Float = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UpdateUI()
    }

    @IBAction func numberPressed(_ sender: UIButton) {
        let totalNumbersOnScreen = screenText.count - Int(truncating: NSNumber(value:dotPressed))
        if showingResult {
            screenText = "\(sender.tag)"
            showingResult = false
        } else if totalNumbersOnScreen < maxNumbersOnScreen {
            if screenText == "0" {
                screenText = "\(sender.tag)"
                if sender.tag != 0 || waitingForSecondNumber { deleteAll = false }
            } else {
                screenText += "\(sender.tag)"
            }
        }
        UpdateUI()

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

        OperationButtonColors(reverse: false)
        lastOperationPressed = sender
        OperationButtonColors(reverse: true)
    }
    
    @IBAction func equalPressed(_ sender: UIButton) {
        if waitingForSecondNumber {
            lastSecondNumber = Float(screenText)!
        }
        CalculateResult()
        screenText = FormatToString(partialResult)

        OperationButtonColors(reverse: false)

        waitingForSecondNumber = false
        dotPressed = false
        showingResult = true

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
        
        OperationButtonColors(reverse: false)
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
        if lastOperationPressed?.tag == 0 {
            partialResult += lastSecondNumber
        } else if lastOperationPressed?.tag == 1 {
            partialResult -= lastSecondNumber
        } else if lastOperationPressed?.tag == 2 {
            partialResult *= lastSecondNumber
        } else if lastOperationPressed?.tag == 3 {
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
    
    fileprivate func OperationButtonColors(reverse : Bool) {
        if reverse {
            lastOperationPressed?.backgroundColor = whiteColor
            lastOperationPressed?.setTitleColor(orangeColor, for: .normal)
        } else {
            lastOperationPressed?.backgroundColor = orangeColor
            lastOperationPressed?.setTitleColor(whiteColor, for: .normal)
        }
    }

    
}

