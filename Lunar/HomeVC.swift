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

        download_coinmarketcap_data(select_currency: "LTC")
    }
    

    func download_coinmarketcap_data(select_currency: String) {
        let CMC = WebService_CoinMarketCap(convert_currency: Convert_Currencies.litecoin, select_currency: select_currency)
        
//        CMC.return_coin_price { (coin_price) in
//            print(coin_price)
//            // stop animating reload - or have reload stop via timer with error message?
//        }
        
        CMC.get_all_coin_prices(start_value: 1, end_value: 10) { (coin_prices) in
            print(coin_prices)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

