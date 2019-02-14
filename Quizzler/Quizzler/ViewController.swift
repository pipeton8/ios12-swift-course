//
//  ViewController.swift
//  Quizzler
//
//  Created by Angela Yu on 25/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let questions = QuestionBank().questionList
    let scorePerQuestion : Int = 100
    var maxWidth : CGFloat = 0
    var numberOfQuestions : Int = 0
    var score : Int = 0
    var questionIndex : Int = 0
    var answerWasCorrect = false
    var gameOver = false
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var progressBar: UIView!
    @IBOutlet weak var progressLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        InitializeUI()
    }

    @IBAction func answerPressed(_ sender: AnyObject) {
        checkAnswer(sender.tag == 1)
        if questionIndex < questions.count - 1 { nextQuestion() }
        else { gameOver = true }
        updateUI()
        if gameOver { SetRestartPrompt() }
    }
    
    func InitializeUI() {
        maxWidth = view.frame.size.width
        numberOfQuestions = questions.count
        questionLabel.text = questions[questionIndex].questionText
        updateUI()
    }
    
    func SetRestartPrompt() {
        let resetPrompt = UIAlertController(title: "Game Over", message: "You have finished! Do you want to play again?", preferredStyle: .alert)
        resetPrompt.addAction(UIAlertAction(title: "Yes!", style: .default, handler: { (UIAlertAction) in self.startOver() }))
        resetPrompt.addAction(UIAlertAction(title: "Hell yes!", style: .default, handler: { (UIAlertAction) in self.startOver() }))
        resetPrompt.preferredAction = resetPrompt.actions[1]
        present(resetPrompt, animated: true)
    }
    
    func updateUI() {
        if answerWasCorrect {
            score += scorePerQuestion
            answerWasCorrect = false
        }
        scoreLabel.text = "Score: \(score)"
        progressLabel.text = "\(questionIndex+1)/\(numberOfQuestions)"
        progressBar.frame.size.width = maxWidth * CGFloat(questionIndex+1) / CGFloat(numberOfQuestions)
    }
    
    func nextQuestion() {
        questionIndex += 1
        questionLabel.text = questions[questionIndex].questionText
    }
    
    func checkAnswer(_ answer : Bool) {
        if answer == questions[questionIndex].answer {
            ProgressHUD.showSuccess("Correct! ;)")
            answerWasCorrect = true
        } else {
            ProgressHUD.showError("Wrong :(")
            answerWasCorrect = false
        }
    }
    
    func startOver() {
        questionIndex = 0
        score = 0
        gameOver = false
        questionLabel.text = questions[questionIndex].questionText
        updateUI()
    }
    

    
}
