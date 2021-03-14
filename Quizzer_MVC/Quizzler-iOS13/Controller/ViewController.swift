//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var questionLabel: UILabel!
    @IBOutlet var choice1Button: UIButton!
    @IBOutlet var choice3Button: UIButton!
    @IBOutlet var progressBar: UIProgressView!
    @IBOutlet var choice2Button: UIButton!
    
    var quizBrain = QuizBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        let userAnswer = sender.currentTitle! // a, b, c
        let userGotItRight = quizBrain.checkAnswer(userAnswer)
        
        if userGotItRight {
            sender.backgroundColor = UIColor.green
        } else { sender.backgroundColor = UIColor.red
        }
        quizBrain.nextQuestion()
      
        Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    }
    
    @objc func updateUI(){
        choice1Button.setTitle(quizBrain.getchoice(1), for: .normal)
        choice2Button.setTitle(quizBrain.getchoice(2), for: .normal)
        choice3Button.setTitle(quizBrain.getchoice(3), for: .normal)
        questionLabel.text = quizBrain.getQuestionText()
        choice1Button.backgroundColor = UIColor.clear
        choice2Button.backgroundColor = UIColor.clear
        choice3Button.backgroundColor = UIColor.clear
        progressBar.progress = quizBrain.getProgressBar()
        scoreLabel.text = "Score: \(quizBrain.getScore())"
    }
    

}

