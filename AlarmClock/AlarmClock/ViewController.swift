//
//  ViewController.swift
//  AlarmClock
//
//  Created by abc on 2021/02/01.
//

import UIKit

class ViewController: UIViewController {
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0
    var count = 0
    var alarmTime: String?

    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblSelectedTime: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func dateSelectPicker(_ sender: UIDatePicker) {
        let selectedDate = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        alarmTime = formatter.string(from: selectedDate.date)
        
        lblSelectedTime.text = "선택시간: " + formatter.string(from: selectedDate.date)
    }
    
    @objc func updateTime() { //저기 타임인터벌 시간마다 이친구가 계속 불림
        let date = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        let currentTime: String = formatter.string(from: date as Date)

        
        
        lblCurrentTime.text = "현재시간: " + formatter.string(from: date as Date)
        count = count + 1
        if(alarmTime == currentTime){
            view.backgroundColor = UIColor.red
            count = 0
            print(count)
        }
        print(count)
        if(count == 60){
            view.backgroundColor = UIColor.white
        }
                
        
    }
}

