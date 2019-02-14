//
//  QuestionBank.swift
//  Quizzler
//
//  Created by Felipe Del Canto Monge on 2/14/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class QuestionBank {
    
    var questionList = [Question]()
    
    init() {
        questionList.append(Question("Valentine\'s day is banned in Saudi Arabia.", correctAnswer: true))
        questionList.append(Question("A slug\'s blood is green.", correctAnswer: true))
        questionList.append(Question("Approximately one quarter of human bones are in the feet.", correctAnswer: true))
        questionList.append(Question("The total surface area of two human lungs is approximately 70 square metres.", correctAnswer: true))
        questionList.append(Question("In West Virginia, USA, if you accidentally hit an animal with your car, you are free to take it home to eat.", correctAnswer: true))
        questionList.append(Question("In London, UK, if you happen to die in the House of Parliament, you are technically entitled to a state funeral, because the building is considered too sacred a place.", correctAnswer: false))
        questionList.append(Question("It is illegal to pee in the Ocean in Portugal.", correctAnswer: true))
        questionList.append(Question("You can lead a cow down stairs but not up stairs.", correctAnswer: false))
        questionList.append(Question("Google was originally called \"Backrub\".", correctAnswer: true))
        questionList.append(Question("Buzz Aldrin\'s mother\'s maiden name was \"Moon\".", correctAnswer: true))
        questionList.append(Question("The loudest sound produced by any animal is 188 decibels. That animal is the African Elephant.", correctAnswer: false))
        questionList.append(Question("No piece of square dry paper can be folded in half more than 7 times.", correctAnswer: false))
        questionList.append(Question("Chocolate affects a dog\'s heart and nervous system; a few ounces are enough to kill a small dog.", correctAnswer: true))
    }
}
