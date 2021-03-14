//
//  Question.swift
//  Quizzler-iOS13
//
//  Created by abc on 2021/03/14.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation


struct Question {
    let text: String
    let answer: [String]
    let cAnswer: String
    
    init(q: String, a: [String], correctAnswer: String) {
        text = q
        answer = a
        cAnswer = correctAnswer
    }
}
