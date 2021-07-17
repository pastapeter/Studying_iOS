//
//  main.swift
//  BankManager_concurrency
//
//  Created by abc on 2021/07/17.
//

import Foundation

    func main(clientCount: Int){
        //Teller은 3명임
        //줄을 각 teller에 3개를 세워야함 -> teller에 줄을 각자 만들어주면되지?
        //각 클래스에 teller의 줄을 만들어주기위해서는 init에 그냥 각자에 할당할수 있는 줄을 만들어주면된다.
        //그리고 그 queue를 한번에 dispatchgroup에 묶어준다.
        //gcd로 어떻게해야할까?
        
        let tellers = Tellers(tellerNumber: 3).list
        
        let windows = DispatchGroup()
        var client = 1
        while client <= clientCount {
            for teller in tellers {
                if teller.isWorking {
                    continue
                }
                teller.handleBusiness(for: client, with: windows)
                client += 1
            }
        }
        
        
    }


main(clientCount: 10)




