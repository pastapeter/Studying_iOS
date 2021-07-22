//
//  Error.swift
//  NetworkingStudy
//
//  Created by abc on 2021/07/22.
//

import Foundation


enum URLError: Error, CustomStringConvertible{
    var description: String {
        switch self {
        case .invalidURL:
            return "invalidURL"
        
        }
    }
    
    case invalidURL
}
