//
//  ViewController.swift
//  GestureRecognizer_pracitce
//
//  Created by abc on 2021/07/26.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

//    @IBAction private func tapView(_ sender: UITapGestureRecognizer) {
//        self.view.endEditing(true)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture: UIGestureRecognizer = UIGestureRecognizer()
        tapGesture.delegate = self
        
        self.view.addGestureRecognizer(tapGesture)
//        let tapRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapView(gestureRecognizer:)))
//
//        self.view.addGestureRecognizer(tapRecognizer)
    }
    
//    @objc func tapView(gestureRecognizer: UIGestureRecognizer) {
//        self.view.endEditing(true)
//    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    

}
