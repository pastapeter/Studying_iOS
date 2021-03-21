//
//  ResultViewController.swift
//  Tipsy
//
//  Created by abc on 2021/03/21.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet var totalLabel: UILabel!
    @IBOutlet var settingLabel: UILabel!
    
    var totalResult: Float?
    var person: Int = 2
    var percent: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        totalLabel.text = String(format: "%.2f", totalResult ?? 0.0)
        settingLabel.text = "Split between \(person) people, with \(percent ?? "0%") tip."
        

    }
    

    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
