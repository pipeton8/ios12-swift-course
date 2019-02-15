//
//  StoryLine.swift
//  Destini
//
//  Created by Felipe Del Canto Monge on 2/15/19.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import Foundation

class StoryLine {
    var stories = [Story]()
    
    init() {
        // Story 0
        let answers0 = ["I\'ll hop in. Thanks for the help!" : 2, "Better ask him if he\'s a murderer first." : 1]
        let story0 = Story("Your car has blown a tire on a winding road in the middle of nowhere with no cell phone reception. You decide to hitchhike. A rusty pickup truck rumbles to a stop next to you. A man with a wide brimmed hat with soulless eyes opens the passenger door for you and asks: \"Need a ride, boy?\".", answers: answers0)
        stories.append(story0)
        
        // Story 1
        let answers1 = ["At least he\'s honest. I\'ll climb in." : 2, "Wait, I know how to change a tire." : 3]
        let story1 = Story("He nods slowly, unphased by the question.", answers : answers1)
        stories.append(story1)
        
        // Story 2
        let answers2 = ["I love Elton John! Hand him the cassette tape." : 5, "It\'s him or me! You take the knife and stab him." : 4]
        let story2 = Story("As you begin to drive, the stranger starts talking about his relationship with his mother. He gets angrier and angrier by the minute. He asks you to open the glovebox. Inside you find a bloody knife, two severed fingers, and a cassette tape of Elton John. He reaches for the glove box.", answers : answers2)
        stories.append(story2)
        
        // Story 3
        let story3 = Story("What? Such a cop out! Did you know traffic accidents are the second leading cause of accidental death for most adult age groups?")
        stories.append(story3)

        // Story 4
        let story4 = Story("As you smash through the guardrail and careen towards the jagged rocks below you reflect on the dubious wisdom of stabbing someone while they are driving a car you are in.")
        stories.append(story4)
        
        // Story 5
        let story5 = Story("You bond with the murderer while crooning verses of \"Can you feel the love tonight\". He drops you off at the next town. Before you go he asks you if you know any good places to dump bodies. You reply: \"Try the pier.\"")
        stories.append(story5)
    }
}
