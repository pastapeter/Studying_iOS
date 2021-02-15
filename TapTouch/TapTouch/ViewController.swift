//
//  ViewController.swift
//  TapTouch
//
//  Created by abc on 2021/02/15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var txtMessage: UILabel!
    @IBOutlet var txtTapCount: UILabel!
    @IBOutlet var txtTouchCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // 터치가 시작될때 호출된다.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch // 현재 발생한 터치 이벤트를 가지고 온다.
        txtMessage.text = "Touches Began" // 메서드에서 현재 발생한 이벤트의 종류를 출력한다.
        txtTapCount.text = String(touch.tapCount) // touches 세트 안에 포함된 터치의 개수를 출력한다.
        txtTouchCount.text = String(touches.count) // 터치 객체들 중 첫번째 객체에서 탭의 개수를 가져와 출력한다.
    }
    
    // 터치된 손가락이 움직였을 때 호출된다.
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch // 현재 발생한 터치 이벤트를 가지고 온다.
        txtMessage.text = "Touches Moved" // 메서드에서 현재 발생한 이벤트의 종류를 출력한다.
        txtTapCount.text = String(touch.tapCount) // touches 세트 안에 포함된 터치의 개수를 출력한다.
        txtTouchCount.text = String(touches.count) // 터치 객체들 중 첫번째 객체에서 탭의 개수를 가져와 출력한다.
    }
    
    // 화면에서 손가락을 떼었을 때 호출된다.
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch // 현재 발생한 터치 이벤트를 가지고 온다.
        txtMessage.text = "Touches Ended" // 메서드에서 현재 발생한 이벤트의 종류를 출력한다.
        txtTapCount.text = String(touch.tapCount) // touches 세트 안에 포함된 터치의 개수를 출력한다.
        txtTouchCount.text = String(touches.count) // 터치 객체들 중 첫번째 객체에서 탭의 개수를 가져와 출력한다.
    }

    
}

