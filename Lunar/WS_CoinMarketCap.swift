//
//  WS_CoinMarketCap.swift
//  Lunar
//
//  Created by Daniel Lee on 7/8/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import Foundation

enum Convert_Currencies: String {
    case bitcoin = "BTC"
    case bitcoin_cash = "BCH"
    case ethereum = "ETH"
    case USD = "USD"
    case litecoin = "LTC"
}

class WebService_CoinMarketCap: NSObject {
    
    let link_listings: String = "https://api.coinmarketcap.com/v2/listings/"
    let link_ticker: String = "https://api.coinmarketcap.com/v2/ticker/"
    var convert_currency: Convert_Currencies?
    var select_currency: String?
    
    init(convert_currency: Convert_Currencies, select_currency: String) {
        self.convert_currency = convert_currency
        self.select_currency = select_currency
    }
    
    func return_coin_price(completion: @escaping (Double) -> ()){
        
        // retrieve the coin_id
        
        get_coin_id { (coin_id) in
            
            // use coin_id to retreive the coin price
            
            self.get_coin_price(coin_id: coin_id, completion: { (coin_price) in
                completion(coin_price)
            })
        }
    }
    
    
    func get_coin_id(completion: @escaping (Int) -> ()){
        guard let url_input = URL(string: self.link_listings) else { return }
        
        var coin_id: Int?
        
        URLSession.shared.dataTask(with: url_input) { (data, response, error) in
            if error != nil {
                print("error retrieving json data in WebService_CoinMarketCap")
                return
            }
            guard let downloaded_data = data else { return }
            if let json_data = try? JSONSerialization.jsonObject(with: downloaded_data, options: .mutableContainers) as? [String:AnyObject] {
                guard let listing_data = json_data?["data"] as? [AnyObject] else { return }
                for (index, listing) in listing_data.enumerated() {
                    guard let symbol = listing["symbol"] as? String else { return }
                    print(symbol)
                    if symbol == self.select_currency {
                        coin_id =  index
                        break
                    }
                }
                guard let valid_coin_id = coin_id else { return }
                DispatchQueue.main.async {
                    completion(valid_coin_id)
                }
            }
        }.resume()
    }
    

    func get_coin_price(coin_id: Int, completion: @escaping (Double) -> ()) {
        guard let conversion_currency = self.convert_currency?.rawValue else { return }
        guard let url_input = URL(string: self.link_ticker + String(coin_id) + "/?convert=" + conversion_currency) else { return }
        
        URLSession.shared.dataTask(with: url_input) { (data, response, error) in
            guard let downloaded_data = data else { return }
            if let json_data = try? JSONSerialization.jsonObject(with: downloaded_data, options: .mutableContainers) as? [String:AnyObject] {
                if let coin_data = json_data?["data"] as? [String:AnyObject] {
                    print(1)
                    guard let coin_prices = coin_data["quotes"] as? [String: AnyObject] else { return }
                    print(2)
                    guard let price_quote = coin_prices[conversion_currency] as? [String: AnyObject] else { return }
                    print(3)
                    guard let price = price_quote["price"] as? Double else { return }
                    print(4)
                    DispatchQueue.main.async {
                        completion(price)
                    }
                }
            }
        }.resume()
        
        
        
    }
    
}