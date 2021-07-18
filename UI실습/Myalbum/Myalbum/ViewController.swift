//
//  ViewController.swift
//  Myalbum
//
//  Created by abc on 2021/01/17.
//
<<<<<<< HEAD
// closure = {} 코드블럭
=======
>>>>>>> 930f47d0cd506e542b793bfacf7db9d7c282dcd7

import UIKit

class ViewController: UIViewController {

<<<<<<< HEAD
    var currentValue = 0
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }


    @IBAction func showAlert(_ sender: Any) {
        let message = "가격은 \(currentValue) 입니다."
        let alert = UIAlertController(title:"HELLO", message:message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: {action in
            self.refresh()
        })
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func refresh(){
        let randomPrice = arc4random_uniform(10000)+1
        currentValue = Int(randomPrice)
        priceLabel.text = "₩\(currentValue)"
    }
    
=======
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


>>>>>>> 930f47d0cd506e542b793bfacf7db9d7c282dcd7
}

