//
//  ViewController.swift
//  moya_practice
//
//  Created by abc on 2021/08/08.
//

import UIKit
import Moya

struct Joke: Decodable {
    var type: String
    var value: Value
    
    struct Value: Decodable {
        var id: Int
        var joke: String
    }
}

class ViewController: UIViewController {
    @IBOutlet var jokeTextview: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        let provider = MoyaProvider<JokeAPI>()
        provider.request(.randomJokes("gildong", "hong")) { (result) in
            switch result {
            case let.success(response):
                let result = try? response.map(Joke.self)
                self.jokeTextview.text = result?.value.joke
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }


}

