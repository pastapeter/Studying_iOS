//
//  UserInformation.swift
//  Navigation_practice
//
//  Created by abc on 2021/07/25.
//

import Foundation


class UserInformation {
    static let shared = UserInformation()
    
    private init(){}
    
    var name: String?
    var age: String?
}
