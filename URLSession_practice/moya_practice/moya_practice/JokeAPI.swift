//
//  JokeAPI.swift
//  moya_practice
//
//  Created by abc on 2021/08/08.
//

import Foundation
import Moya

enum JokeAPI {
    case randomJokes(_ firstName: String? = nil, _ lastName: String? = nil)
}

extension JokeAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.icndb.com")!
    }
    
    var path: String {
        switch self {
        case .randomJokes(_, _):
            return "/jokes/random"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .randomJokes(_, _):
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .randomJokes(let firstName, let lastName):
            let firstName = firstName
            let lastName = lastName
            
            return Data(
                """
                {
                    "type" : "success",
                    "value": {
                        "id": 107,
                        "joke" : "\(firstName ?? "도현")\(lastName ?? "정") can retrieve Anything from /dev/null."
                    }
                }
                """.utf8
            )
        }
    }
        
    var task: Task {
        switch self {
        case .randomJokes(let firstName, let lastName):
            let params: [String: Any] = [
                "firstName": firstName as Any,
                "lastName" : lastName as Any
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
