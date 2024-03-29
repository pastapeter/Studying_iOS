//
//  Bank.swift
//  BankManager_concurrency
//
//  Created by abc on 2021/07/18.
//

import Foundation

class Bank {
    private var clients : [Client] = []
    private var tellers : [Teller] = []
    private var finishedClientCount: Int = 0
    private var businessTime: TimeInterval?
    
    func open(teller: [Teller], client: [Client]) {
        //teller 은행원수 이미 정해져있음
        //client
        let openDate = Date()
        
        tellers = teller
        clients = client.sorted(by: { client1, client2 in
            client1.priority > client2.priority
        })
        assignBusinessToTeller()
        businessTime = Date().timeIntervalSince(openDate)
        DashBoard.printCloseMessage(clients.count, businessTime: businessTime)
        resetFinishedClientCount()
    }
    
    private func assignBusinessToTeller(){
        let windows = DispatchGroup()
        var clientIndex = clients.count-1
        var isContinuous = true
        while isContinuous {
            for teller in tellers {
                if clientIndex == -1 {
                    isContinuous = false
                    break
                }
                if teller.isNotworking {
                    teller.handleBusiness(client: clients[clientIndex], with: windows)
                    clientIndex -= 1
                }
            }
        }
//        windows.notify(queue: DispatchQueue.main){
//            print("모든손님의 일처리를 모두 마무리했다!!!")
//        }
        windows.wait()
        print("모든손님의 일처리를 모두 마무리했다!!!")
    }
    private func resetFinishedClientCount(){
        finishedClientCount = 0
        clients.removeAll()
    }
}
