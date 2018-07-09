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
        
        print("HomeVC init")
        
        
//        download_coinmarketcap_data(select_currency: "LTC")
    }
    

    func download_coinmarketcap_data(select_currency: String) {
        let CMC = WebService_CoinMarketCap(convert_currency: Convert_Currencies.litecoin, select_currency: select_currency)
        
        CMC.return_coin_price { (coin_price) in
            print(coin_price)
            // stop animating reload - or have reload stop via timer with error message?
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

