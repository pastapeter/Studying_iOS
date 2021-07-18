//
//  Bank.swift
//  BankManager_concurrency
//
//  Created by abc on 2021/07/18.
//

import Foundation

class Bank {
    private var clients = [Client]()
    private var tellers = [Teller]()
    private var finishedClientCount: Int = 0
    private var businessTime: TimeInterval?
    
    init() {
        <#statements#>
    }
    
    func open(teller: [Teller], client: [Client]) {
        
    }
    private func assignBusinessToTeller(){
        
    }
    private func resetFinishedClientCount(){
        
    }
}
