//
//  Teller.swift
//  BankManager_concurrency
//
//  Created by abc on 2021/07/17.
//

import Foundation

class Teller {
    private var windowInBank: Int
    private var isWorking = false
    var isNotworking = true
    let workingQueue : DispatchQueue
    
    init(windowInBank: Int) {
        self.windowInBank = windowInBank
        self.workingQueue = DispatchQueue(label: "\(windowInBank)")
    }
    
    func handleBusiness(client: Client, with group: DispatchGroup){
        isWorking = true
        isNotworking = false
        workingQueue.async(group: group) {
            switch client.businessType {
                case .deposit:
                    self.handleDeposit(client: client)
                case .loan:
                    self.handleLoan(client: client)
            }
            self.isWorking = false
            self.isNotworking = true
        }
    }
    
    private func handleDeposit(client : Client){
        let clientBusinessType = client.businessType
        let delayTime = clientBusinessType.needTimeToProcess
       
        DashBoard.printStatus(for: client, about: Message.tellerStart)
        Thread.sleep(forTimeInterval: delayTime)
        DashBoard.printStatus(for: client, about: Message.tellerFinish)
    }
    
    private func handleLoan(client : Client){
        reviewDocument(client: client)
        sendDocumentToHeadOffice(client: client)
        finishLoan(client: client)
    }
    
    private func sendDocumentToHeadOffice(client: Client){
        let semaphore = DispatchSemaphore(value: 0)
        
        HeadOffice.shared.LoanQueue.async {
            HeadOffice.shared.judgeLoan(client: client)
            semaphore.signal()
        }
        semaphore.wait()
    }
    
    private func reviewDocument(client: Client){
        DashBoard.printStatus(for: client, about: Message.tellerStart)
        Thread.sleep(forTimeInterval: client.businessType.needTimeToProcess)
    }
    
    private func finishLoan(client: Client){
        Thread.sleep(forTimeInterval: client.businessType.needTimeToProcess)
        DashBoard.printStatus(for: client, about: Message.tellerFinish)
    }
}
