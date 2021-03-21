//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    
    @IBOutlet var billTextField: UITextField!
    @IBOutlet var zeroPctButton: UIButton!
    @IBOutlet var tenPctButton: UIButton!
    @IBOutlet var twentyPctButton: UIButton!
    @IBOutlet var splitNumberLabel: UILabel!
    
    //calculatorBrain = calculatorBrain()

    var result: Float?
    var num: Int = 2
    var percent: String?
    
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField.endEditing(true)
        if (sender == zeroPctButton){
            zeroPctButton.isSelected = true
            tenPctButton.isSelected = false
            twentyPctButton.isSelected = false
        } else if(sender == tenPctButton){
            tenPctButton.isSelected = true
            zeroPctButton.isSelected = false
            twentyPctButton.isSelected = false
        } else if(sender == twentyPctButton){
            twentyPctButton.isSelected = true
            tenPctButton.isSelected = false
            zeroPctButton.isSelected = false
        }
        percent = sender.currentTitle ?? "0%"
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = Int(sender.value).description
        num = Int(sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let getText = billTextField.text ?? "0.0"
        let getText2 = splitNumberLabel.text ?? "0.0"
        if zeroPctButton.isSelected{
            print(Float(getText)! / Float(getText2)!)
            result = Float(getText)! / Float(getText2)!
        } else if tenPctButton.isSelected {
            print( Float(getText)! / Float(getText2)! * 1.1)
           result = Float(getText)! / Float(getText2)! * 1.1
        } else {
            print(Float(getText)! / Float(getText2)! * 1.2)
            result = (Float(getText)! / Float(getText2)! * 1.2)
        }
        self.performSegue(withIdentifier: "resultSegue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "resultSegue" {
            let destinationVC = segue.destination as! ResultViewController
            destinationVC.totalResult = result
            destinationVC.person = num
            destinationVC.percent = percent
        }
    }
}

