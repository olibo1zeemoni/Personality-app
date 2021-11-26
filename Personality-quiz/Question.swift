//
//  Question.swift
//  Personality-quiz
//
//  Created by Olibo moni on 26/11/2021.
//

import Foundation

struct Question{
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer{
    var text: String
    var type: AnimalType
}

enum AnimalType: Character {
   
    
    case dog = "🐶", cat = "🐱", rabbit = "🐰", turtle = "🐢"
    
    var definition: String {
        switch self {
        case .dog:
            return " You are incredibly outgoing. You surround yourself with the people you love and enjoy  activities with your friend "
        case .cat:
            return "Mischievous yet mild tempered. you enjoy doing things on your own terms"
        case .rabbit:
            return "you love everything that is soft. You're healthy and full of life"
        case .turtle:
            return "you're wise beyond your years and you focus on the details. Slow and steady wins the race"
          }
    }
    
}
