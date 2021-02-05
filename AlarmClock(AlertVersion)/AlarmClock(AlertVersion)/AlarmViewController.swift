//
//  ViewController.swift
//  AlarmClock(AlertVersion)
//
//  Created by abc on 2021/02/02.
//

import UIKit

class AlarmViewController: UIViewController {
    
    let timeSelector: Selector = #selector(AlarmViewController.updateTime)
    let interval = 1.0
    var count = 1
    var alarmTime: String?
    var flag = false

    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblSelectedTime: UILabel!
    @IBOutlet var timeDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func selectTimePicker(_ sender: UIDatePicker) {
        let datepicker = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        alarmTime = formatter.string(from: datepicker.date)
        lblSelectedTime.text = "선택시간: " + formatter.string(from: datepicker.date)
    }
    
    @objc func updateTime(){
        let currentTime = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss EEE"
        let currentClock = formatter.string(from: currentTime as Date)
        lblCurrentTime.text = "현재시간: " + formatter.string(from: currentTime as Date)
        count = count + 1
        let isTime = UIAlertController(title: "알림", message: "설정된 시간입니다!!!", preferredStyle: UIAlertController.Style.alert)
        let turnOffAlarm = UIAlertAction(title: "네 알겠습니다", style: UIAlertAction.Style.default, handler: {Action in self.count = 0
        })
        if(alarmTime == currentClock){
            flag = true
            count = 1
            isTime.addAction(turnOffAlarm)
            present(isTime, animated: true, completion: nil)
        }
        if(flag==true && count == 60){
            self.dismiss(animated: true, completion: nil)
            flag = false
        }
        
        
    }
    
    
}

