//
//  Clients.swift
//  BankManager_concurrency
//
//  Created by abc on 2021/07/17.
//

import Foundation

struct Clients{
    var list = [Client]()
    
    init(ClientNumbers : Int){
        for Clientnumber in 1...ClientNumbers{
            let businessRandom = Int.random(in: 0..<2)
            let priorityRandom = Int.random(in: 0..<3)
            list.append(Client(waitingNumber: Clientnumber, businessType: BusinessType.allCases[businessRandom], priority: Priority.allCases[priorityRandom]))
        }
    }
}
