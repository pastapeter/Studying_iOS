//
//  Teller.swift
//  BankManager_concurrency
//
//  Created by abc on 2021/07/17.
//

import Foundation

class Teller {
    var windowInBank: Int
    var isWorking = false
    let workingQueue : DispatchQueue
    
    init(windowInBank: Int) {
        self.windowInBank = windowInBank
        self.workingQueue = DispatchQueue(label: "\(windowInBank)")
    }
    
    func handleBusiness(client: Client, with group: DispatchGroup){
        isWorking = true
        workingQueue.async(group: group) {
            print("은행원 \(self.windowInBank)번 is working for \(client.waitingNumber)번 고객")
            Thread.sleep(forTimeInterval: 3)
            print("은행원 \(self.windowInBank)번 finished working \(client.waitingNumber)번 고객")
            self.isWorking = false
        }
    }
    
    private func handleDeposit(client : Client){
        let clientBusinessType = client.businessType
        let delayTime = clientBusinessType.needTimeToProcess
        print("은행원 \(self.windowInBank)번 is working for \(client.waitingNumber)번 고객 with \(client.businessType)")
        Thread.sleep(forTimeInterval: delayTime)
    }
    
    private func handleLoan(client : Client){
        
    }
    
    private func sendDocumentToHeadOffice(client: Client){
        
    }
    
    private func reviewDocument(client: Client){
        
    }
    
    private func finishLoan(client: Client){
        
    }
}
