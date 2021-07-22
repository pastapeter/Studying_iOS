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
            return "invalid URL"
        case .invalidResponse:
            return "invalid Response"
        case .invalidData:
            return "invalid Data"
        }
    }
    
    case invalidURL
    case invalidResponse
    case invalidData
}
