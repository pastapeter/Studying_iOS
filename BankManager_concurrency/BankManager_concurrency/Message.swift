//
//  Message.swift
//  BankManager_concurrency
//
//  Created by abc on 2021/07/18.
//

import Foundation

enum Message{
    static let close = "업무가 끝났습니다. 오늘업무를 처리한 고객은 총 %d명이며, 총 업무시간 %.2f초입니다."
    static let tellerStart = "%d번 %@고객 %@업무 시작"
    static let tellerFinish = "%d번 %@고객 %@업무 완료"
    static let loanStart = "%d번 %@고객 %@심사 시작"
    static let loanEnd = "%d번 %@고객 심사 완료"
}
