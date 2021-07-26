//
//  SecondViewController.swift
//  Navigation_practice
//
//  Created by abc on 2021/07/24.
//

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("SecondViewController가 load된다.")
        // Do any additional setup after loading the view.
    }
    
    @IBAction func PopToPrev() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dismissModal() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.nameLabel.text = UserInformation.shared.name
        self.ageLabel.text = UserInformation.shared.age
    }
 
}
