//
//  ViewController.swift
//  DrawFlower
//
//  Created by abc on 2021/02/14.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnStart(_ sender: UIButton) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        //원 4개
        let circleX: CGFloat = 120
        let circleY: CGFloat = 150
        let circleWidth: CGFloat = 100
        let circleHeight: CGFloat = 100
        let move: CGFloat = 50
        
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.blue.cgColor)
        
        var circle = [CGRect]()
        circle.append(CGRect(x: circleX, y: circleY, width: circleWidth, height: circleHeight))
        circle.append(CGRect(x: circleX + move, y: circleY, width: circleWidth, height: circleHeight))
        circle.append(CGRect(x: circleX - move, y: circleY, width: circleWidth, height: circleHeight))
        circle.append(CGRect(x: circleX, y: circleY - move, width: circleWidth, height: circleHeight))
        circle.append(CGRect(x: circleX, y: circleY + move, width: circleWidth, height: circleHeight))
        
        
        for i in circle{
            context.addEllipse(in: i)
        }
        context.strokePath()
        
        // 삼각형 1개
        context.setLineWidth(1.0)
        context.setStrokeColor(UIColor.green.cgColor)
        context.setFillColor(UIColor.green.cgColor)
        
        
        context.move(to: CGPoint(x: 170, y: 200))
        context.addLine(to: CGPoint(x: 200, y: 450))
        context.addLine(to: CGPoint(x: 140, y: 450))
        context.addLine(to: CGPoint(x: 170, y: 200))
        context.fillPath()
        context.strokePath()
        
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
}

