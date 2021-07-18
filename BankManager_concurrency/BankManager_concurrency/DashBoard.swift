//
//  DashBoard.swift
//  BankManager_concurrency
//
//  Created by abc on 2021/07/17.
//

import Foundation

struct DashBoard {
    static func printMenu(){
        print(Menu.description)
    }
    
    static func printStatus(for client: Client, about message: String){
        print(String.init(format: message, client.waitingNumber, "\(client.priority)", "\(client.businessType)"))
    }
    
    static func printCloseMessage(){
       
    }
    
}
