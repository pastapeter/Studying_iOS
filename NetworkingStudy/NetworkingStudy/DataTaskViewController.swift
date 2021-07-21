//
//  ViewController.swift
//  NetworkingStudy
//
//  Created by abc on 2021/07/22.
//

import UIKit

class DataTaskViewController: UIViewController {

    @IBAction private func sendRequest(_ sender: Any){
        let booksUrlStr = "https://kxcoding-study.azurewebsites.net/api/books"
        
        guard let url = URL(string: booksUrlStr) else {
            fatalError("invalid URL")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

