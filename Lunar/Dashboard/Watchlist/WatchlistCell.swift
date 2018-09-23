//
//  WatchlistCell.swift
//  Lunar
//
//  Created by Daniel Lee on 9/22/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class WatchlistCell: DashboardBaseCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var crypto: Crypto? {
        didSet {
            assign_cell_labels()
        }
    }
    
    let side_insets: CGFloat = 5
    let roof_insets: CGFloat = 5
    
    // Total height should be less than 1.0
    let section1_height: CGFloat = 0.2
    let section2_height: CGFloat = 0.3
    let section3_height: CGFloat = 0.2
    
    let container_view = UIView()
    let coin_img = UIImageView()
    let symbol_lbl = UILabel()
    let name_lbl = UILabel()
    let usd_price_lbl = UILabel()
    let h24_lbl = UILabel()
    let h1_lbl = UILabel()
    let d7_lbl = UILabel()
    
    func set_up_view() {
        add_container_view()
        add_coin_name()
        add_coin_prices()
    }
    
    fileprivate func add_container_view() {
        self.addSubview(container_view)
        container_view.translatesAutoresizingMaskIntoConstraints = false
        container_view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: side_insets).isActive = true
        container_view.topAnchor.constraint(equalTo: self.topAnchor, constant: roof_insets).isActive = true
        container_view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -side_insets).isActive = true
        container_view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -roof_insets).isActive = true
    }
    
    fileprivate func add_coin_name() {
        self.addSubview(symbol_lbl)
        self.addSubview(name_lbl)
        symbol_lbl.style_stock_symbol_label(font_size: 10, font_color: Theme_color2, autolayout: true)
        name_lbl.style_stock_name_label(font_size: 10, font_color: .white, autolayout: true)
        
        symbol_lbl.leadingAnchor.constraint(equalTo: container_view.leadingAnchor).isActive = true
        symbol_lbl.topAnchor.constraint(equalTo: container_view.topAnchor).isActive = true
        symbol_lbl.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: 0.3).isActive = true
        symbol_lbl.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: self.section1_height).isActive = true
        
        name_lbl.leadingAnchor.constraint(equalTo: symbol_lbl.trailingAnchor).isActive = true
        name_lbl.topAnchor.constraint(equalTo: container_view.topAnchor).isActive = true
        name_lbl.trailingAnchor.constraint(equalTo: container_view.trailingAnchor).isActive = true
        name_lbl.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: self.section1_height).isActive = true
    }
    
    fileprivate func add_coin_prices() {
        self.addSubview(usd_price_lbl)
        usd_price_lbl.style_stock_usd_price_label(font_size: 10, font_color: Theme_color2, autolayout: true)
        
        usd_price_lbl.leadingAnchor.constraint(equalTo: container_view.leadingAnchor).isActive = true
        usd_price_lbl.topAnchor.constraint(equalTo: name_lbl.bottomAnchor).isActive = true
        usd_price_lbl.trailingAnchor.constraint(equalTo: container_view.trailingAnchor).isActive = true
        usd_price_lbl.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: section2_height).isActive = true
    }
    
    fileprivate func add_performance_indicators() {
        self.addSubview(h24_lbl)
        self.addSubview(h1_lbl)
        self.addSubview(d7_lbl)
        h24_lbl.style_stock_price_label(font_size: 8, font_color: .white, autolayout: true)
        h1_lbl.style_stock_price_label(font_size: 8, font_color: .white, autolayout: true)
        d7_lbl.style_stock_price_label(font_size: 8, font_color: .white, autolayout: true)
        
        h1_lbl.leadingAnchor.constraint(equalTo: container_view.leadingAnchor).isActive = true
        h1_lbl.topAnchor.constraint(equalTo: usd_price_lbl.bottomAnchor).isActive = true
        h1_lbl.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: 0.2).isActive = true
        h1_lbl.bottomAnchor.constraint(equalTo: container_view.bottomAnchor).isActive = true
        
        h24_lbl.leadingAnchor.constraint(equalTo: h1_lbl.leadingAnchor).isActive = true
        h24_lbl.topAnchor.constraint(equalTo: usd_price_lbl.bottomAnchor).isActive = true
        h24_lbl.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: 0.3).isActive = true
        h24_lbl.bottomAnchor.constraint(equalTo: container_view.bottomAnchor).isActive = true
        
        h24_lbl.leadingAnchor.constraint(equalTo: container_view.leadingAnchor).isActive = true
        h24_lbl.topAnchor.constraint(equalTo: usd_price_lbl.bottomAnchor).isActive = true
        h24_lbl.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: 0.2).isActive = true
        h24_lbl.bottomAnchor.constraint(equalTo: container_view.bottomAnchor).isActive = true
    }
    
    fileprivate func assign_cell_labels() {
        usd_price_lbl.text = currencyConverter(aDouble: self.crypto?.usd_data.price ?? 0)
        symbol_lbl.text = self.crypto?.symbol
        name_lbl.text = self.crypto?.name
        h1_lbl.text = "\(self.crypto?.usd_data.pct_1h ?? 0)"
        h24_lbl.text = "\(self.crypto?.usd_data.pct_24h ?? 0)"
        d7_lbl.text = "\(self.crypto?.usd_data.pct_1week ?? 0)"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
