//
//  ViewController.swift
//  imageView
//
//  Created by abc on 2021/01/31.
//

import UIKit

class ViewController: UIViewController {
    var isZoom = false
    var imgOn: UIImage?
    var imgOff: UIImage?
    
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var btnResize: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imgOn = UIImage(named: "0D196205-5CE7-4FD7-9942-11F71E899BCC_1_105_c.jpeg" )
        imgOff = UIImage(named: "8467188C-1403-49BF-8731-54033587F73A_1_105_c.jpeg")
        
        imgView.image = imgOn
    }

    
    @IBAction func btnResizeImage(_ sender: UIButton) {
        let scale:CGFloat = 2.0
        
        var newWidth:CGFloat, newHeight:CGFloat
        
        if (isZoom){
            newWidth = imgView.frame.width/scale
            newHeight = imgView.frame.height/scale
            btnResize.setTitle("확대", for: .normal) //normal은 그냥 기본값의 글씨
        } else{
            newWidth = imgView.frame.width*scale
            newHeight = imgView.frame.height*scale
            btnResize.setTitle("축소", for: .normal) //normal은 그냥 기본값의 글씨
        }
        imgView.frame.size = CGSize(width: newWidth, height: newHeight)
        isZoom = !isZoom
//        newWidth = newWidth * scale
//        newHeight = newHeight * scale
    }
    
    @IBAction func switchImg(_ sender: UISwitch) {
        if sender.isOn {
            imgView.image = imgOn
        } else {
            imgView.image = imgOff
        }
        
    }
    
}

