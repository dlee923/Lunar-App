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
        
        set_up_home_dashboard()

        download_coinmarketcap_data(select_currency: "LTC")
    }
    
    var coins: [Crypto]?

    func download_coinmarketcap_data(select_currency: String) {
        let CMC = WebService_CoinMarketCap(select_currency: select_currency)
        
//        CMC.return_coin_price { (coin_price) in
//            print(coin_price)
//            // stop animating reload - or have reload stop via timer with error message?
//        }
        
        CMC.get_all_coin_prices(start_value: 1, end_value: 10, convert_currency: Convert_Currencies.litecoin) {(coin_prices) in
            self.coins = coin_prices
        }
    }
    
    func set_up_home_dashboard() {
        let home_dashboard = HomeDashboard()
        home_dashboard.coins = self.coins
        self.view.addSubview(home_dashboard)
        home_dashboard.translatesAutoresizingMaskIntoConstraints = false
        home_dashboard.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        home_dashboard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        home_dashboard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        home_dashboard.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

