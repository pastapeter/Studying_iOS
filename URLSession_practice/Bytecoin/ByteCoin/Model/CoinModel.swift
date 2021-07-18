//
//  CoinModel.swift
//  ByteCoin
//
//  Created by abc on 2021/04/11.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel{
    let asset_id_quote: String
    let rate: Double
    
    init(_ asset_id_quote: String, _ rate: Double) {
        self.asset_id_quote = asset_id_quote
        self.rate = rate
    }
}
