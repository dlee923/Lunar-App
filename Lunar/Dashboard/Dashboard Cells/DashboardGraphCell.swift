//
//  DashboardGraphCell.swift
//  Lunar
//
//  Created by Daniel Lee on 7/11/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

extension UILabel {
    
    func style_stock_symbol_label(font_size: CGFloat, font_color: UIColor, autolayout: Bool) {
        self.translatesAutoresizingMaskIntoConstraints = autolayout ? false : true
        self.font = font_future_forces?.withSize(font_size)
        self.textColor = font_color
    }
    
    func style_stock_price_label(font_size: CGFloat, font_color: UIColor, autolayout: Bool) {
        self.translatesAutoresizingMaskIntoConstraints = autolayout ? false : true
        self.textColor = font_color
        self.font = font_simple_tech?.withSize(font_size)
    }
}

class DashboardGraphCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
    }
    
    let stock_symbol_lbl = UILabel()
    let stock_price_lbl = UILabel()
    var crypto: Crypto?
    
    func set_up_stock_cell() {
        self.addSubview(stock_symbol_lbl)
        stock_symbol_lbl.style_stock_symbol_label(font_size: 40, font_color: .white, autolayout: true)
        
        self.addSubview(stock_price_lbl)
        stock_price_lbl.style_stock_price_label(font_size: 15, font_color: .white, autolayout: true)
        
        stock_symbol_lbl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stock_symbol_lbl.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stock_symbol_lbl.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stock_symbol_lbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        
        stock_price_lbl.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stock_price_lbl.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stock_price_lbl.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        stock_price_lbl.topAnchor.constraint(equalTo: stock_symbol_lbl.bottomAnchor).isActive = true
        
        stock_symbol_lbl.text = crypto?.symbol
        
        if let crypto_price = crypto?.crpto_price {
            stock_price_lbl.text = "\(crypto_price)"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
