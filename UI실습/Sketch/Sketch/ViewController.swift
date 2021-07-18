//
//  ViewController.swift
//  Sketch
//
//  Created by abc on 2021/02/15.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    
    var lastPoint: CGPoint! // 바로 전에 터치하거나 이동한 위치
    var lineSize: CGFloat = 2.0 // 선의 두께
    var lineColor = UIColor.red.cgColor // 선의 색상
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func clearImageView(_ sender: UIButton) {
        imgView.image = nil
    }
    
    // 사용자가 화면을 터치하면 스케치를 시작하도록 touchesBegan 메서드를 구현
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        lastPoint = touch.location(in: imgView) //이미지뷰안에서 터치된 위치를 변수에 저장?
    }
    
    // touchesMoved 메서드 구현 터치한 손가락을 움직이면 스케치도 따라서 움직임
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round) // 라인의 끝 모양을 라운드로 설정한다.
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        let touch = touches.first! as UITouch
        let currPoint = touch.location(in: imgView) // 터치된 위치를 currPoint로 가지고 온다.
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height)) //현재 이미지뷰에 있는 이미지를 이미지뷰 크기로 그린다.
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currPoint // 현재 터치된포인트를 전에 터치된포인트 변수로 옮긴다.
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round) // 라인의 끝 모양을 라운드로 설정한다.
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height)) //현재 이미지뷰에 있는 이미지를 이미지뷰 크기로 그린다.
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y)) // 터치가 마무리되니깐 다른 장소로 안옮기는 것 + 점은 찍히는것?
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
       
    }
    
    // iOS 기기가 흔들렸을때 이미지 뷰위에 그렸던 스케치가 지워지도록
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        imgView.image = nil
    }

}

