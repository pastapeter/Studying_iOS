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
    
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var txMessage: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = imgOn
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as! EditViewController
        if segue.identifier == "editButton" {
            //버튼 클릭?
            editViewController.textWayValue = "segue : use button"
        } else if segue.identifier == "editBarButton" {
            // Bar 버튼 클릭?
            editViewController.textWayValue = "segue : use bar button"
        }
        editViewController.textMessage = txMessage.text!
        editViewController.isOn = isOn
        editViewController.delegate = self // 뭔말?
        
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
    
}

