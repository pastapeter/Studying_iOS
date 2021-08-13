//
//  ViewController.swift
//  GetPost
//
//  Created by abc on 2021/08/10.
//

import UIKit



class ViewController: UIViewController {
  @IBOutlet weak var currentTime: UILabel!
  @IBOutlet weak var idtextfield: UITextField!
  @IBOutlet weak var name: UITextField!
  @IBOutlet weak var responseView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  @IBAction func callCurrentTime(_ sender: UIButton) {
    
    let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/currentTime")
    
    
    do {
      
      
      let response = try String(contentsOf: url!)
      
      self.currentTime.text = response
      self.currentTime.sizeToFit()
      
    } catch  {
      print(error.localizedDescription)
    }
    
  }
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.view.endEditing(true)
  }
  
  
  @IBAction func post(_ sender: UIButton) {
    //전송준비
    let userId = self.idtextfield.text!
    let name = self.name.text!
    let param = "userId=\(userId)&name\(name)"
    // 인코딩
    let paramData = param.data(using: .utf8)
    
    // URL 객체정의
    let url = URL(string: "http://swiftapi.rubypaper.co.kr:2029/practice/echo")

    // URLrequest정의
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    request.httpBody = paramData
    
    // 해더 설정
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.setValue(String(paramData!.count), forHTTPHeaderField: "Content-Length")
    
    // task 만들어주기
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let e = error {
        print(e.localizedDescription)
      }
      DispatchQueue.main.async {
        do {
          let object = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
          guard let jsonObject = object else {return}
          let result = jsonObject["result"] as? String
          let timestamp = jsonObject["timestamp"] as? String
          let userId = jsonObject["userId"] as? String
          let name = jsonObject["name"] as? String
          
          if result == "SUCCESS" {
            self.responseView.text = "아이디 \(userId!), \(name!), \(result!), \(timestamp!), "
          }
        } catch {
          print(error.localizedDescription)
        }
      }
    }
    task.resume()
  }
  
}

