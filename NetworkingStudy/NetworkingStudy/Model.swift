//
//  Model.swift
//  NetworkingStudy
//
//  Created by abc on 2021/07/22.
//

import Foundation


struct Book: Codable {
    let id: Int
    let title: String
    let desc: String
    let link: String
    let date: Date
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case desc = "description"
        case link = "yes24Link"
        case date = "publicationDate"
    }
}


struct BookList: Codable {
    var list: [Book]
    var totalCount: Int
    var code: Int
    var message: String?
}
