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
        
        self.view.backgroundColor = Theme_color1
        // Do any additional setup after loading the view, typically from a nib.
        
        /*
         download coins and current prices
        */
//        download_coinmarketcap_data(select_currency: "LTC")
        
        
        /*
         set up dashboard
        */
        set_up_home_dashboard()
        
        /*
         *download* test coin data
        */
        test_coin_data()
        
        self.navigationItem.titleView = title_label
        
        self.navigationItem.leftBarButtonItem = set_up_navigation(button_size: 30, button_image: #imageLiteral(resourceName: "menu2_150"))
        self.navigationItem.rightBarButtonItem = set_up_profile(button_size: 30, button_image: nil)
    }
    
    let app_title = "Lunar"
    let home_dashboard_inset_border: CGFloat = 0
    
    var coins: [Crypto]? {
        didSet {
            // download coin histories
            home_dashboard.coins = self.coins
        }
    }
    var is_menu_displayed: Bool = false
    var settings_view_center: NSLayoutConstraint?
    weak var home_dashboard: HomeDashboard!
    
    lazy var title_label: UILabel = {
        let title_label = UILabel(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        title_label.text = self.app_title
        title_label.textAlignment = .center
        title_label.font = font_space_ranger2?.withSize(20)
        title_label.textColor = Theme_color1
        return title_label
    }()
    
    var settings_view: SettingsView?
    

// MARK: Multiple Coin Functions
    fileprivate func download_coinmarketcap_data(select_currency: String) {
        let CMC = WebService_CoinMarketCap(select_currency: select_currency)
        
        CMC.get_all_coin_prices(start_value: 1, end_value: 10, convert_currency: Convert_Currencies.litecoin) {(coin_prices) in
            self.coins = coin_prices
            
            // stop animating reload - or have reload stop via timer with error message?
            // download coin histories
//            self.download_coin_histories(coins: self.coins!)
        }
    }
    
    fileprivate func download_coin_histories(coins: [Crypto]) {
        for coin in coins {
            let symbol = coin.symbol
            let price_history = download_crypto_compare_data(select_currency: symbol, convert_currency: "USD", interval_type: .minute, interval: 5, history_length: 10, type: .close)
            coin.price_history = price_history
        }
    }
    
    
// MARK: Singular Coin Functions
    fileprivate func download_crypto_compare_data(select_currency: String, convert_currency: String, interval_type: Interval_Type, interval: Int, history_length: Int, type: Price_Types) -> [Double] {
        let CC = WebService_CryptoCompare(select_currency: select_currency, convert_currency: convert_currency, interval_type: interval_type, interval: interval, history_length: history_length)
        
        var price_history: [Double]?
        
        CC.download_coin_history { (candlestick_prices) in
            
            price_history = self.create_coin_history(prices: candlestick_prices, type: type)
        }
        
        return price_history ?? [0]
    }
    
    func create_coin_history(prices: [CandleStick_Price], type: Price_Types) -> [Double]{
        var price_history = [Double]()
        
        if type == Price_Types.open {
            for price in prices {
                price_history.append(price.open)
            }
        }
        
        if type == Price_Types.close {
            for price in prices {
                price_history.append(price.close)
            }
        }
        
        if type == Price_Types.high {
            for price in prices {
                price_history.append(price.high)
            }
        }
        
        if type == Price_Types.low {
            for price in prices {
                price_history.append(price.low)
            }
        }
        
        return price_history
    }

    
// MARK: Test Coin Data
    func test_coin_data() {
        let coin1 = Crypto(symbol: "LTC", name: "Litecoin",
                           conversion_data: PriceData(price: 1.0, volume_24: 4514250.9122193689, market_cap: 57902584.0, pct_1h: 0.0, pct_24h: 0.0, pct_1week: 0.0),
                           usd_data: PriceData(price: 56.301533579199997, volume_24: 254159249.319253, market_cap: 3260004250.0, pct_1h: -0.14000000000000001, pct_24h: -5.25, pct_1week: -3.6600000000000001),
                           price_history: nil,
                           rank: 7)
        
        let coin2 = Crypto(symbol: "BTC", name: "Bitcoin",
                           conversion_data: PriceData(price: 113.64586432519999, volume_24: 73007800.689443424, market_cap: 1956707556.0, pct_1h: 0.14999999999999999, pct_24h: 3.5899999999999999, pct_1week: 4.79),
                           usd_data: PriceData(price: 6398.4364464399996, volume_24: 4110451142.0602398, market_cap: 110165636181.0, pct_1h: 0.01, pct_24h: -1.8500000000000001, pct_1week: 0.95999999999999996),
                           price_history: [10, 25, 13, 16, 12, 21, 22, 18],
                           rank: 1)
        
        let coin3 = Crypto(symbol: "FTC",
                           name: "Cryptocoin",
                           conversion_data: PriceData(price: 0.00092854760000000004, volume_24: 513.01030202080005, market_cap: 194788.0, pct_1h: 0.14000000000000001, pct_24h: 6.2800000000000002, pct_1week: 2.8500000000000001),
                           usd_data: PriceData(price: 0.0522786529, volume_24: 28883.2667456979, market_cap: 10966884.0, pct_1h: -0.0, pct_24h: 0.69999999999999996, pct_1week: -0.91000000000000003),
                           price_history: [10, 25, 13, 16, 12, 21, 22, 18],
                           rank: 314)
        
        let coin4 = Crypto(symbol: "NVC",
                           name: "Cryptocoin",
                           conversion_data: PriceData(price: 0.076153406300000004, volume_24: 129.18959060430001, market_cap: 164191.0, pct_1h: 2.8700000000000001, pct_24h: 29.030000000000001, pct_1week: 2.73),
                           usd_data: PriceData(price: 4.2875535642999996, volume_24: 7273.5720734906999, market_cap: 9244206.0, pct_1h: 2.7200000000000002, pct_24h: 22.25, pct_1week: -1.03),
                           price_history: [10, 25, 13, 16, 12, 21, 22, 18],
                           rank: 343)
        
        let coin5 = Crypto(symbol: "NMC",
                           name: "Cryptocoin",
                           conversion_data: PriceData(price: 0.0272810642, volume_24: 1115.8129492817, market_cap: 402025.0, pct_1h: 2.1600000000000001, pct_24h: 11.470000000000001, pct_1week: -21.949999999999999),
                           usd_data: PriceData(price: 1.5359657513, volume_24: 62821.980232088397, market_cap: 22634606.0, pct_1h: 2.0099999999999998, pct_24h: 5.6100000000000003, pct_1week: -24.809999999999999),
                           price_history: nil,
                           rank: 189)
        
        let coin6 = Crypto(symbol: "TRC",
                           name: "Cryptocoin",
                           conversion_data: PriceData(price: 0.0012833929, volume_24: 107.93938775559999, market_cap: 29435.0, pct_1h: -0.050000000000000003, pct_24h: 5.2199999999999998, pct_1week: 6.4500000000000002),
                           usd_data: PriceData(price: 0.072256986300000006, volume_24: 6077.1530642408998, market_cap: 1657243.0, pct_1h: -0.19, pct_24h: -0.31, pct_1week: 2.5600000000000001),
                           price_history: nil,
                           rank: 719)
        
        let coin7 = Crypto(symbol: "MNC",
                           name: "Cryptocoin",
                           conversion_data: PriceData(price: 0.00019835569999999999, volume_24: 0.48570519070000001, market_cap: 938.0, pct_1h: 0.28999999999999998, pct_24h: 4.6900000000000004, pct_1week: -22.469999999999999),
                           usd_data: PriceData(price: 0.011167732200000001, volume_24: 27.345947101499998, market_cap: 52813.0, pct_1h: 0.14999999999999999, pct_24h: -0.81000000000000005, pct_1week: -25.309999999999999),
                           price_history: nil,
                           rank: 1341)
        
        let coin8 = Crypto(symbol: "IXC",
                           name: "Cryptocoin",
                           conversion_data: PriceData(price: 0.00089491569999999995, volume_24: 38.993802047099997, market_cap: 18805.0, pct_1h: 0.34999999999999998, pct_24h: -0.14999999999999999, pct_1week: -4.1100000000000003),
                           usd_data: PriceData(price: 0.050385126199999998, volume_24: 2195.4108553368001, market_cap: 1058741.0, pct_1h: 0.20000000000000001, pct_24h: -5.4000000000000004, pct_1week: -7.6200000000000001),
                           price_history: [10, 25, 13, 16, 12, 21, 22, 18],
                           rank: 800)
        
        let coin9 = Crypto(symbol: "FRC",
                           name: "Cryptocoin",
                           conversion_data: PriceData(price: 8.1609199999999998e-05, volume_24: 0.041690975399999997, market_cap: 2556.0, pct_1h: 0.28999999999999998, pct_24h: 3.5, pct_1week: 3.4399999999999999),
                           usd_data: PriceData(price: 0.0045947241000000002, volume_24: 2.3472658513, market_cap: 143905.0, pct_1h: 0.14999999999999999, pct_24h: -1.9399999999999999, pct_1week: -0.34000000000000002),
                           price_history: [10, 25, 13, 16, 12, 21, 22, 18],
                           rank: 1236)
        
        let coin10 = Crypto(symbol: "PPC",
                            name: "Cryptocoin",
                            conversion_data: PriceData(price: 0.019483206999999999, volume_24: 9262.7111549515994, market_cap: 485441.0, pct_1h: 0.46000000000000002, pct_24h: -1.78, pct_1week: -30.329999999999998),
                            usd_data: PriceData(price: 1.0969344334, volume_24: 521504.84312493599, market_cap: 27331096.0, pct_1h: 0.31, pct_24h: -6.9400000000000004, pct_1week: -32.880000000000003),
                            price_history: [10, 25, 13, 16, 12, 21, 22, 18],
                            rank: 162)
        
        let coin_list = [coin1, coin2, coin3, coin4, coin5, coin6, coin7, coin8, coin9, coin10]
        
        for coin in coin_list {
            coin.price_history = [10.0, 25.0, 13.0, 16.0, 12.0, 21.0, 22.0, 18.0]
        }
        
        self.coins = coin_list
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

