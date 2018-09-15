//
//  Crypto.swift
//  Lunar
//
//  Created by Daniel Lee on 9/15/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import Foundation

class Crypto {
    let symbol: String
    let name: String
    var conversion_data: PriceData
    var usd_data: PriceData
    var price_history: [Double]?
    var rank: Int
    
    init(symbol: String, name: String, conversion_data: PriceData, usd_data: PriceData, price_history: [Double]?, rank: Int){
        self.symbol = symbol
        self.name = name
        self.conversion_data = conversion_data
        self.usd_data = usd_data
        self.rank = rank
    }
}


struct PriceData {
    var price: Double
    var volume_24: Double
    var market_cap: Double
    var pct_1h: Double
    var pct_24h: Double
    var pct_1week: Double
}
