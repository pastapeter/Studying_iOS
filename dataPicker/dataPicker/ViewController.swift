//
//  ViewController.swift
//  dataPicker
//
//  Created by abc on 2021/02/01.
//

import UIKit

class ViewController: UIViewController {
    
    let timeSelector: Selector = #selector(ViewController.updateTime)
    let interval = 1.0 // 타이머의 간격 값 -> 1.0 은 1초를 가르킴
    var count = 0 // 타이머가 설정한 간격대로 실행되는지 확인하기 위한 변수

    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblSelectedTiem: UILabel!
    @IBOutlet var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
    }

    @IBAction func dateSelect(_ sender: UIDatePicker) {
        let datePickerView = sender
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        lblSelectedTiem.text = "선택시간: " + formatter.string(from: datePickerView.date)
        
    }
    
    @objc func updateTime(){
//        lblCurrentTime.text = "현재시간: " + String(count)
//        count = count + 1
        let date = NSDate() //현재시간을 NSDate()로 가져올 수 있다.
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm EEE"
        lblCurrentTime.text = "현재시간: " + formatter.string(from: date as Date) //string과 dateformat과 맞지 않을 경우 nil을 빼야하므로 옵셔널임
    }
    
}

