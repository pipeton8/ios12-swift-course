//
//  Story.swift
//  Destini
//
//  Created by Felipe Del Canto Monge on 2/15/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class Story {
    
    let text : String
    let isFinal : Bool
    var answers = [String]()
    var consequences = [Int]() // answers[i] leads to story consequences[i]
    
    init(_ text : String, answers : [String : Int] = [:]) {
        self.text = text
        for(answer, consequence) in answers {
            self.answers.append(answer)
            self.consequences.append(consequence)
        }
        isFinal = answers.count == 0
    }
}
