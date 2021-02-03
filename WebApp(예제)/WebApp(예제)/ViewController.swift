//
//  ViewController.swift
//  WebApp(예제)
//
//  Created by abc on 2021/02/03.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    @IBOutlet var WorkFlowView: WKWebView!
    
    func loadWebpage(_ url: String){
        let myUrl = URL(string: url)
        let myRequest = URLRequest(url: myUrl!)
        WorkFlowView.load(myRequest)
    }
    func filePath(){
        let filePath = Bundle.main.path(forResource: "htmlView", ofType: "html")
        let myUrl = URL(fileURLWithPath: filePath!)
        let myRequest = URLRequest(url: myUrl)
        WorkFlowView.load(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filePath()
    }
//이름 생년월일, 계좌번호, 납입증명서,

}

