//
//  WS_CryptoCompare.swift
//  Lunar
//
//  Created by Daniel Lee on 7/27/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import Foundation

enum Interval_Type: String {
    case minute = "minute"
    case hour = "hour"
    case day = "day"
}

class WebService_CryptoCompare: NSObject {
    
    init(select_currency: String, convert_currency: String, interval_type: Interval_Type, interval: Int, history_length: Int) {
        super.init()
        self.select_currency = select_currency
        self.convert_currency = convert_currency
        self.interval_type = interval_type
        self.interval = interval
        self.history_length = history_length
    }
    
    var select_currency: String?
    var convert_currency: String?
    var interval_type: Interval_Type?
    var interval: Int?
    var history_length: Int?
    let base_url = "https://min-api.cryptocompare.com/data/histo"
    
    
    func download_coin_history() {
        let api_url = base_url + "\(self.interval_type!)" + "?fsym=" + "\(self.select_currency!)" + "&tsym=" + "\(self.convert_currency!)" + "&limit=" + "\(self.history_length!)" + "&aggregate=" + "\(self.interval!)" + "&e=CCCAGG"
        
        guard let url = URL(string: api_url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("Error fetching CryptoCompare Data")
            }
            guard let downloaded_data = data else { return }
            if let json_data = try? JSONSerialization.jsonObject(with: downloaded_data, options: .mutableContainers) as? [String:Any] {
                if let prices = json_data?["Data"] as? [Any] {
                    
                    print(prices)
                }
                DispatchQueue.main.async {
//                    print(json_data)
                }
                
            }
        }.resume()
    }
    
}
