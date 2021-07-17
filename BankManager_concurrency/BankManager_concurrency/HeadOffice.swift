//
//  HeadOffice.swift
//  BankManager_concurrency
//
//  Created by abc on 2021/07/17.
//

import Foundation

class HeadOffice {
    
    static let shared = HeadOffice()
    private let needTimeToJudgeLoan : TimeInterval = 2.0
    let LoanQueue = DispatchQueue.init(label: "LoanQueue", attributes: .concurrent)
    private init(){}
    
    func judgeLoan(client: Client){
        
    }
    
}

