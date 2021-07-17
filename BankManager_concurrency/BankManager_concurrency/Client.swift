//
//  Client.swift
//  BankManager_concurrency
//
//  Created by abc on 2021/07/17.
//

import Foundation

enum Priority: Comparable, CaseIterable, CustomStringConvertible {
    var description: String {
        switch self {
        case .VIP:
            return "VIP"
        case .VVIP:
            return "VVIP"
        case .normal:
            return "normal"
        }
    }
    
    case VVIP, VIP, normal
}

struct Client{
    let waitingNumber: Int
    let businessType: BusinessType
    var priority: Priority
    
    init(waitingNumber: Int, businessType: BusinessType = .deposit, priority: Priority = .normal) {
        self.waitingNumber = waitingNumber
        self.businessType = businessType
        self.priority = priority
    }
}

extension Client : Equatable, Comparable {
    static func < (lhs: Client, rhs: Client) -> Bool {
        return lhs.priority < rhs.priority
    }
    static func == (lhs: Client, rhs: Client) -> Bool {
        return lhs.priority == rhs.priority
    }
    
}
