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
        
        CMC.return_coin_price { (coin_price) in
            print(coin_price)
        }
        
    }
    
    let CMC = WebService_CoinMarketCap(convert_currency: Convert_Currencies.litecoin, select_currency: "LTC")

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

