//
//  ViewController.swift
//  Navigation_practice
//
//  Created by abc on 2021/07/24.
//

import UIKit

class FirstViewController: UIViewController {
    
    
    @IBOutlet private weak var nameField: UITextField!
    @IBOutlet private weak var ageField: UITextField!
    
    @IBAction func touchUpSetButton(_ sender: UIButton) {
        UserInformation.shared.name = nameField.text
        UserInformation.shared.age = ageField.text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Viewcontroller의 view가 메모리에 로드됨")
    }
    
    


}

