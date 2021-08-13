//
//  request.swift
//  GetPost
//
//  Created by abc on 2021/08/10.
//

import Foundation
import Alamofire


struct Response: Codable {
  let success: Bool
  let result: String
  let message: String
}
//BODY가 없는 요청
func requestGet(url: String, completionHandler: @escaping (Bool, Any) -> Void){
  guard let url = URL(string: url) else {
    print("error: cant create URL")
    return
  }
  var request = URLRequest(url: url)
  request.httpMethod = "GET"
  
  URLSession.shared.dataTask(with: request) { (data, response, error) in
    guard error == nil else {
      print(error?.localizedDescription)
      return
    }
    guard let response = response as? HTTPURLResponse else {return}
    guard response.statusCode > 199 && response.statusCode < 300 else {
      return
    }
    guard let data = data else {
      return
    }
    
    guard let output = try? JSONDecoder().decode(Response.self, from: data) else {return}
    completionHandler(true, output.result)
  }.resume()
}

func requestPost(url: String, method: String, param: [String: Any],
                 completionHandler: @escaping (Bool, Any) -> Void) {
  let sendData = try! JSONSerialization.data(withJSONObject: param, options: [])
  guard let url = URL(string: url) else {return}
  var request = URLRequest(url: url)
  request.httpMethod = "POST"
  request.addValue("application/json", forHTTPHeaderField: "Content-Type")
  request.httpBody = sendData
  
  URLSession.shared.dataTask(with: request) { (data, response, error) in
    guard error == nil else {
      print(error!)
      return
    }
    guard let response = response as? HTTPURLResponse else {return}
    guard response.statusCode > 199 && response.statusCode < 300 else {
      return
    }
    guard let data = data else {
      return
    }
    
    guard let output = try? JSONDecoder().decode(Response.self, from: data) else {return}
    completionHandler(true, output.result)
  }.resume()
  
}

func request(_ url: String, _ method: String, _ param: [String : Any]? = nil,
             completionHandler: @escaping (Bool, Any) -> Void) {
  if method == "GET" {
    requestGet(url: url) { (success, data) in
      completionHandler(success, data)
    }
  } else {
    requestPost(url: url, method: method, param: param!) { (sucess, data) in
      completionHandler(sucess, data)
    }
  }
}

func alamoGet(_ url: String) {
  AF.request(url).responseJSON() { response in
    switch response.result {
    case .success:
      if let data = try! response.result.get() as? [String: Any] {
        print(data)
      }
    case .failure(let error):
      print("Error: \(error)")
      return
    }
  }
}

func alamoPost(_ url: String, _ param: [String: Any]) {
  AF.request(url, method: .post, parameters: param, encoding: URLEncoding.httpBody).responseJSON() { response in
    switch response.result {
    case .success:
      if let data = try! response.result.get() as? [String: Any] {
        print(data)
      }
    case .failure(let error):
      print("Error: \(error)")
      return
    }
  }
}
