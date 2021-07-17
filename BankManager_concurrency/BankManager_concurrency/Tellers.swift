//
//  Tellers.swift
//  BankManager_concurrency
//
//  Created by abc on 2021/07/17.
//

import Foundation

struct Tellers {
    var list = [Teller]()
    
    init(tellerNumber: Int) {
        for windowNumber in 1...tellerNumber {
            list.append(Teller(windowInBank: windowNumber))
        }
    }
}
