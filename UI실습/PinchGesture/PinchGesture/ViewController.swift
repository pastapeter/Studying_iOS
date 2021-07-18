//
//  ViewController.swift
//  PinchGesture
//
//  Created by abc on 2021/02/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    
    var initialFontSize: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.doPinch(_:))) //클래스 상수 pinch 선언한다. 액션 인수는 핀치 제스처가 인식되었을때 실행할 메서드를 의미
        self.view.addGestureRecognizer(pinch)
    }


    @objc func doPinch(_ pinch: UIPinchGestureRecognizer){
        imgView.transform = imgView.transform.scaledBy(x: pinch.scale, y: pinch.scale)
        pinch.scale = 1 // 다음변환을 위해서 핀치 스케일을 초기화해주는 과정
        
        
//        if(pinch.state == UIGestureRecognizer.State.began){ //핀치제스처의 상태를 state 속성을 사용하여 확인합니다.
//            initialFontSize = txtPinch.font.pointSize // 만약 핀치 제스처의 상태가 시작이면 앞에서 선언한 initailFontsize 변수에 현재 택스트 글자크기를 저장한다.
//        } else{ //처음이 아니라면 핀치제스처가 계속진행되고 있다는 소리 -> 이니셜폰트사이즈에 저장해둔 글자 크기 값에 스케일 속성을 곱하여 택스트의 글자 크기에 반영한다.
//            txtPinch.font = txtPinch.font.withSize(initialFontSize * pinch.scale)
//        }
//    }
    }
}

