//
//  ViewController.swift
//  SketchBook
//
//  Created by abc on 2021/02/16.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var btnLineWidth: UIButton!
    @IBOutlet var btnBlack: UIButton!
    @IBOutlet var btnRed: UIButton!
    @IBOutlet var btnGreen: UIButton!
    @IBOutlet var btnBlue: UIButton!
    
    var buttonList = [UIButton]()
    var lastPoint: CGPoint!
    var lineSize: CGFloat = 1.0
    var lineColor = UIColor.black.cgColor
    
    let MAX_SIZE : CGFloat = 5.0


    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonList.append(btnBlack)
        buttonList.append(btnRed)
        buttonList.append(btnGreen)
        buttonList.append(btnBlue)
        btnBlack.isSelected = true
        btnLineWidth.setTitle("두께 \(Int(lineSize))", for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        lastPoint = touch.location(in: imgView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        
        let touch = touches.first! as UITouch
        let currPoint = touch.location(in: imgView)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    
    @IBAction func setStrokeBlack(_ sender: UIButton) {
        setButton(buttonName: 0)
        lineColor = UIColor.black.cgColor
    }
    @IBAction func setStrokeRed(_ sender: UIButton) {
        setButton(buttonName: 1)
        lineColor = UIColor.red.cgColor
    }
    @IBAction func setStrokeGreen(_ sender: UIButton) {
        setButton(buttonName: 2)
        lineColor = UIColor.green.cgColor

    }
    @IBAction func setStrokeBlue(_ sender: UIButton) {
        setButton(buttonName: 3)
        lineColor = UIColor.blue.cgColor
    }
    @IBAction func setLineWidth(_ sender: UIButton) {
        if(lineSize < 5.0){
            lineSize = lineSize + 1.0
        } else if(lineSize == 5.0) {
            lineSize = 1.0
        }
        btnLineWidth.setTitle("두께\(Int(lineSize))", for: .normal)
    }
    @IBAction func setClear(_ sender: UIButton) {
        imgView.image = nil
    }
    
    func setButton(buttonName: Int){
        for i in buttonList{
            if(buttonList[buttonName] == i){
                i.isSelected = true
            } else {
                i.isSelected = false
            }
        }
    }
    

}

