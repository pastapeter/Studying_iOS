//
//  ViewController.swift
//  Navigation
//
//  Created by abc on 2021/02/05.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    
    var isOn = true
    var isZoom = false // 축소
    var orgZoom = false
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var txMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = imgOn
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as! EditViewController
        if segue.identifier == "editButton" { //세그웨이의 이름이 editbutton이라면?
            //버튼 클릭?
            editViewController.textWayValue = "segue : use button"
        } else if segue.identifier == "editBarButton" { //세그웨이의 이름이 editBarButton이라면?
            // Bar 버튼 클릭?
            editViewController.textWayValue = "segue : use bar button"
        }
        //수정화면으로 텍스트 메세지와 전구상태 전달
        editViewController.textMessage = txMessage.text!
        editViewController.isOn = isOn
        editViewController.isZoom = orgZoom
        editViewController.delegate = self // viewcontroller는 editviewcontroller에 이벤트가 발생하면 delegate에 따라서 응답을 준다.
        
    }
    
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txMessage.text = message
    }

    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        if isOn {
            imgView.image = imgOn
            self.isOn = true
        } else {
            imgView.image = imgOff
            self.isOn = false
        }
    }
    
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool) {
        
        let scale: CGFloat = 2.0
        var newWidth:CGFloat, newHeight: CGFloat
        if isZoom {
            if orgZoom{
            } else {
                newWidth = imgView.frame.width / scale
                newHeight = imgView.frame.height / scale
                self.isZoom = false
                self.orgZoom = true
                imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            }
            print("ZOOM True")
        }
        else {
            if orgZoom {
                newWidth = imgView.frame.width*scale
                newHeight = imgView.frame.height*scale
                self.isZoom = true
                self.orgZoom = false
                imgView.frame.size = CGSize(width: newWidth, height: newHeight)
            }
            else{
            }
            print("Zoom False")
        }
    }
}

