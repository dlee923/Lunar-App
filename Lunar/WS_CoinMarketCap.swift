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


struct Crypto {
    let symbol: String
    var crpto_price: Double
    var usd_price: Double
    var price_history: [Double]?
    var rank: Int
}


class WebService_CoinMarketCap: NSObject {
    
    let link_listings: String = "https://api.coinmarketcap.com/v2/listings/"
    let link_ticker: String = "https://api.coinmarketcap.com/v2/ticker/"
    var select_currency: String?
    
    
    init(select_currency: String) {
        super.init()
        self.select_currency = select_currency
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
    

    func get_specific_coin_price(coin_id: Int, convert_currency: Convert_Currencies, completion: @escaping (Double) -> ()) {
        let conversion_currency = convert_currency.rawValue
        guard let url_input = URL(string: self.link_ticker + String(coin_id) + "/?convert=" + conversion_currency) else { return }
        
        URLSession.shared.dataTask(with: url_input) { (data, response, error) in
            guard let downloaded_data = data else { return }
            if let json_data = try? JSONSerialization.jsonObject(with: downloaded_data, options: .mutableContainers) as? [String:AnyObject] {
                if let coin_data = json_data?["data"] as? [String:AnyObject] {
                    guard let coin_prices = coin_data["quotes"] as? [String: AnyObject] else { return }
                    guard let price_quote = coin_prices[conversion_currency] as? [String: AnyObject] else { return }
                    guard let price = price_quote["price"] as? Double else { return }
                    DispatchQueue.main.async {
                        completion(price)
                    }
                }
            }
        }.resume()
    }
    
    
    func get_all_coin_prices(start_value: Int, end_value: Int, convert_currency: Convert_Currencies, completion: @escaping ([Crypto]) -> ()) {
        let conversion_currency = convert_currency.rawValue
        guard let url_input = URL(string: self.link_ticker + "?convert=" + conversion_currency + "&start=" + String(start_value) + "&limit=" + String(end_value) + "&sort=id") else { return }

        var downloaded_coin_data = [Crypto]()
        
        URLSession.shared.dataTask(with: url_input) { (data, response, error) in
            guard let downloaded_data = data else { return }
            if let json_data = try? JSONSerialization.jsonObject(with: downloaded_data, options: .mutableContainers) as? [String:AnyObject] {
                if let coin_data = json_data?["data"] as? [String:AnyObject] {
                    for coin_object in coin_data {
                        guard let coin_info = coin_object.value as? [String:AnyObject] else { return }
                        guard let coin_symbol = coin_info["symbol"] as? String else { return }
                        guard let coin_prices = coin_info["quotes"] as? [String: AnyObject] else { return }
                        guard let conversion_price_quote = coin_prices[conversion_currency] as? [String: AnyObject] else { return }
                        guard let conversion_price = conversion_price_quote["price"] as? Double else { return }
                        guard let us_price_quote = coin_prices["USD"] as? [String:AnyObject] else { return }
                        guard let us_price = us_price_quote["price"] as? Double else { return }
                        guard let rank = coin_info["rank"] as? Int else { return }
                        let crypto_obj = Crypto(symbol: coin_symbol, crpto_price: conversion_price, usd_price: us_price, price_history: nil, rank: rank)
                        downloaded_coin_data.append(crypto_obj)
                    }
                }
            }
            DispatchQueue.main.async {
                completion(downloaded_coin_data)
            }
        }.resume()
    }
    
    
    func return_coin_price(completion: @escaping (Double) -> ()){
        // retrieve the coin_id
        get_coin_id { (coin_id) in
            // use coin_id to retreive the coin price
            self.get_specific_coin_price(coin_id: coin_id, convert_currency: Convert_Currencies.litecoin, completion: { (coin_price) in
                completion(coin_price)
            })
        }
    }
    
}
