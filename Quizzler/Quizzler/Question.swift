//
//  Question.swift
//  Quizzler
//
//  Created by Felipe Del Canto Monge on 2/14/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class Question {
    
    let questionText : String
    let answer : Bool
    
    init(_ newText : String, correctAnswer : Bool) {
        questionText = newText
        answer = correctAnswer
    }
}
