//
//  HomeVC.swift
//  Lunar
//
//  Created by Daniel Lee on 7/8/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .purple
        // Do any additional setup after loading the view, typically from a nib.

//        download_coinmarketcap_data(select_currency: "LTC")
        download_crypto_compare_data(select_currency: "BTC", convert_currency: "USD", interval_type: .minute, interval: 5, history_length: 10)
        
        set_up_home_dashboard()
    }
    
    var coins: [Crypto]? {
        didSet {
            home_dashboard.coins = self.coins
        }
    }
    
    let home_dashboard_inset_border: CGFloat = 5
    
    weak var home_dashboard: HomeDashboard!

    func download_coinmarketcap_data(select_currency: String) {
        let CMC = WebService_CoinMarketCap(select_currency: select_currency)
        
        CMC.get_all_coin_prices(start_value: 1, end_value: 10, convert_currency: Convert_Currencies.litecoin) {(coin_prices) in
            self.coins = coin_prices
            // stop animating reload - or have reload stop via timer with error message?
        }
    }
    
    func download_crypto_compare_data(select_currency: String, convert_currency: String, interval_type: Interval_Type, interval: Int, history_length: Int) {
        let CC = WebService_CryptoCompare(select_currency: select_currency, convert_currency: convert_currency, interval_type: interval_type, interval: interval, history_length: history_length)
        
        CC.download_coin_history()
    }
    
    func set_up_home_dashboard() {
        home_dashboard = HomeDashboard()
        home_dashboard.homeVC = self
        self.view.addSubview(home_dashboard)
        home_dashboard.translatesAutoresizingMaskIntoConstraints = false
        home_dashboard.topAnchor.constraint(equalTo: self.view.topAnchor, constant: home_dashboard_inset_border).isActive = true
        home_dashboard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: home_dashboard_inset_border).isActive = true
        home_dashboard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -home_dashboard_inset_border).isActive = true
        home_dashboard.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: (-home_dashboard_inset_border * 4)).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

