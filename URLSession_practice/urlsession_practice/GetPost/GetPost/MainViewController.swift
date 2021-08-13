//
//  MainViewController.swift
//  GetPost
//
//  Created by abc on 2021/08/11.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {
  
  var items: [Displayable] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    fetchFilms()
    // Do any additional setup after loading the view.
  }
  
  
  
  
}

extension MainViewController {
  func fetchFilms() {
    AF.request("https://swapi.dev/api/films")
      .validate().responseDecodable(of: Films.self) { (response) in
        guard let films = response.value else {return}
        print(films.all[0].title)
      }
  }
}
