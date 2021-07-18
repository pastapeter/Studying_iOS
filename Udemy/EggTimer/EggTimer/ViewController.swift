//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    let timeSelector: Selector = #selector(ViewController.updateTime)
    var progress : Float = 0
    var totalTime = 60
    var secondsPassed = 0
    var timer = Timer()
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    var audioFile:URL!
    var audioplayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        audioFile = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
    }
    
    @IBAction func pressEgg(_ sender: UIButton) {
        lblTitle.text = "How do you like to do with your eggs?"
        timer.invalidate()
        initPlay()
        let hardness = sender.currentTitle
            if let hardness = hardness {
                    totalTime = eggTimes[hardness]!
                progressView.progress = 0
                secondsPassed = 0
                lblTitle.text = hardness
                    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        }
    }
    
    func initPlay(){
        do {
           audioplayer =  try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("error \(error)")
        }
        audioplayer.delegate = self
        audioplayer.prepareToPlay()
    }
    
    @objc func updateTime() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            let percentageProgress = Float(secondsPassed) / Float(totalTime)
            progressView.progress = percentageProgress
        } else {
            lblTitle.text = "How are the eggs?"
            timer.invalidate()
            audioplayer.play()
        }
    }
    
 
}
