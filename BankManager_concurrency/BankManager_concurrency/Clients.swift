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
            list.append(Client(waitingNumber: Clientnumber))
        }
    }
}
