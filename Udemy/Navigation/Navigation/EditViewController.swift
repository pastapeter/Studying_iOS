//
//  EditViewController.swift
//  Navigation
//
//  Created by abc on 2021/02/05.
//

import UIKit

protocol EditDelegate {
    func didMessageEditDone(_ controller: EditViewController, message: String)
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool)
    func didImageZoomDone(_ controller: EditViewController, isZoom: Bool )
}

class EditViewController: UIViewController {
    
    var textWayValue: String = ""
    var textMessage: String = ""
    var delegate: EditDelegate?
    var isOn = false
    var isZoom = false
    var btnZoomIn: String = "확대"
    var btnZoomOut: String = "축소"

    @IBOutlet var lblWay: UILabel!
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var swisOn: UISwitch!
    @IBOutlet var btnZoom: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblWay.text = textWayValue
        txMessage.text = textMessage
        swisOn.isOn = isOn
        if isZoom {
            btnZoom.setTitle(btnZoomIn, for: .normal)
        } else {
            btnZoom.setTitle(btnZoomOut, for: .normal)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func swImageOnOff(_ sender: UISwitch) {
        if sender.isOn {
            isOn = true
        } else {
            isOn = false
        }
        
    }
    
    @IBAction func btnZoomOrNot(_ sender: UIButton) {
        if isZoom {
            btnZoom.setTitle(btnZoomOut, for: .normal)
            isZoom = false
        } else {
            btnZoom.setTitle(btnZoomIn, for: .normal)
            isZoom = true
        }
    }
    
    

    @IBAction func btnDone(_ sender: UIButton) {
        if delegate != nil{
            delegate?.didMessageEditDone(self, message: txMessage.text!)
            delegate?.didImageOnOffDone(self, isOn: isOn)
            delegate?.didImageZoomDone(self, isZoom: isZoom)
        }
       _ = navigationController?.popViewController(animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
