//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCoinPrice(_ coinManager: CoinManager, coinPrice: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "E77B3F44-3F9B-464D-B799-36E21CAA155C"
    
    var delegate : CoinManagerDelegate?
    
    func getCoinPrice(for currency: String){
        //1. create URL
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        //2. Create a URLSession
        let session = URLSession(configuration: .default)
        //3. give a session task
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.delegate?.didFailWithError(error: error)
                return
            }
            if let safeData = data{
                if let price = self.ParseData(safeData){
                    self.delegate?.didUpdateCoinPrice(self, coinPrice: price)
                }
            }
        }
        task.resume()
    }
    
    func ParseData(_ data: Data) -> CoinModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            let asset_id_quote = decodedData.asset_id_quote
            let coinModel = CoinModel(asset_id_quote, lastPrice)
            return coinModel
        } catch  {
            print(error)
            return nil
        }
    }
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    
}
