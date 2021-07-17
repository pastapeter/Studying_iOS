//
//  BusinessType.swift
//  BankManager_concurrency
//
//  Created by abc on 2021/07/17.
//

import Foundation

enum BusinessType: CaseIterable {
    case deposit, loan
    
    var needTimeToProcess : TimeInterval {
        switch self {
        case .deposit:
            return 0.3
        case .loan :
            return 0.5
        }
    }
}

extension BusinessType: CustomStringConvertible {
    var description: String {
        switch self {
        case .deposit:
            return "deposit"
        case .loan:
            return "loan"
        }
    }
}
