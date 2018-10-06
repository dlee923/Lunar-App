//
//  WatchlistCell.swift
//  Lunar
//
//  Created by Daniel Lee on 9/22/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class Title_Label: UILabel {
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        self.text = title
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .center
        self.textColor = .white
        self.font = UIFont.font_spy_agency?.withSize(12)
        self.textColor = .white
//        self.sizeToFit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}


class WatchlistCell: DashboardBaseCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        set_up_view()
    }
    
    var crypto: Crypto? {
        didSet {
            assign_cell_labels()
        }
    }
    
    let font_size_price: CGFloat = 15
    let font_size_performance: CGFloat = 13
    let font_size_symbol: CGFloat = 18
    let font_size_name: CGFloat = 12
    
    let performance_arrows_width: CGFloat = 0.075
    let performance_arrows_color = UIColor.Cell_color
    
    let side_insets: CGFloat = 5
    let roof_insets: CGFloat = 5
    
    // Total height should be less than 1.0
    let section1_height: CGFloat = 0.2
    let section3_height: CGFloat = 0.2
    let section4_height: CGFloat = 0.2
    
    let container_view = UIView()
    let coin_img = UIImageView()
    let symbol_lbl = UILabel()
    let name_lbl = UILabel()
    let usd_price_lbl = UILabel()
    let h24_lbl = UILabel()
    let h1_lbl = UILabel()
    let d7_lbl = UILabel()
    let h24_title = Title_Label(frame: .zero, title: "24H")
    let h1_title = Title_Label(frame: .zero, title: "1H")
    let d7_title = Title_Label(frame: .zero, title: "7D")
    let h24_up = UIImageView(image: UIImage(named: "triangle")?.withRenderingMode(.alwaysTemplate))
    let h1_up = UIImageView(image: UIImage(named: "triangle")?.withRenderingMode(.alwaysTemplate))
    let d7_up = UIImageView(image: UIImage(named: "triangle")?.withRenderingMode(.alwaysTemplate))
    let h24_down = UIImageView(image: UIImage(named: "triangle")?.withRenderingMode(.alwaysTemplate))
    let h1_down = UIImageView(image: UIImage(named: "triangle")?.withRenderingMode(.alwaysTemplate))
    let d7_down = UIImageView(image: UIImage(named: "triangle")?.withRenderingMode(.alwaysTemplate))
    
    func set_up_view() {
        add_container_view()
        add_performance_stats()
        add_performance_indicators()
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
        container_view.addSubview(symbol_lbl)
        symbol_lbl.textAlignment = .center
        symbol_lbl.style_stock_symbol_label(font_size: font_size_symbol, font_color: UIColor.Theme_color2, autolayout: true)
        
        symbol_lbl.leadingAnchor.constraint(equalTo: container_view.leadingAnchor).isActive = true
        symbol_lbl.topAnchor.constraint(equalTo: container_view.topAnchor).isActive = true
        symbol_lbl.widthAnchor.constraint(equalTo: container_view.widthAnchor).isActive = true
        symbol_lbl.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: section1_height).isActive = true
    }
    
    fileprivate func add_coin_prices() {
        container_view.addSubview(usd_price_lbl)
        usd_price_lbl.textAlignment = .center
        usd_price_lbl.style_stock_usd_price_label(font_size: font_size_price, font_color: UIColor.Theme_color3, autolayout: true)
        
        usd_price_lbl.leadingAnchor.constraint(equalTo: container_view.leadingAnchor).isActive = true
        usd_price_lbl.bottomAnchor.constraint(equalTo: h24_title.topAnchor).isActive = true
        usd_price_lbl.trailingAnchor.constraint(equalTo: container_view.trailingAnchor).isActive = true
        usd_price_lbl.topAnchor.constraint(equalTo: symbol_lbl.bottomAnchor).isActive = true
    }
    
    fileprivate func add_performance_indicators() {
        h24_up.translatesAutoresizingMaskIntoConstraints = false
        h1_up.translatesAutoresizingMaskIntoConstraints = false
        d7_up.translatesAutoresizingMaskIntoConstraints = false
        
        h24_up.contentMode = .scaleAspectFit
        h1_up.contentMode = .scaleAspectFit
        d7_up.contentMode = .scaleAspectFit
        
        h24_up.tintColor = performance_arrows_color
        h1_up.tintColor = performance_arrows_color
        d7_up.tintColor = performance_arrows_color
        
        container_view.addSubview(h24_title)
        container_view.addSubview(h1_title)
        container_view.addSubview(d7_title)
        
        container_view.addSubview(h24_up)
        container_view.addSubview(h1_up)
        container_view.addSubview(d7_up)
        
        let title_width = (1 - (performance_arrows_width * 3)) / 3
        
        h1_title.leadingAnchor.constraint(equalTo: container_view.leadingAnchor).isActive = true
        h1_title.bottomAnchor.constraint(equalTo: h1_lbl.topAnchor).isActive = true
        h1_title.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: title_width).isActive = true
        h1_title.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: section3_height).isActive = true
        
        h1_up.leadingAnchor.constraint(equalTo: h1_title.trailingAnchor).isActive = true
        h1_up.bottomAnchor.constraint(equalTo: h1_lbl.topAnchor).isActive = true
        h1_up.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: performance_arrows_width).isActive = true
        h1_up.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: section3_height).isActive = true
        
        h24_title.leadingAnchor.constraint(equalTo: h1_up.trailingAnchor).isActive = true
        h24_title.bottomAnchor.constraint(equalTo: h24_lbl.topAnchor).isActive = true
        h24_title.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: title_width).isActive = true
        h24_title.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: section3_height).isActive = true
        
        h24_up.leadingAnchor.constraint(equalTo: h24_title.trailingAnchor).isActive = true
        h24_up.bottomAnchor.constraint(equalTo: h24_lbl.topAnchor).isActive = true
        h24_up.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: performance_arrows_width).isActive = true
        h24_up.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: section3_height).isActive = true
        
        d7_title.leadingAnchor.constraint(equalTo: h24_up.trailingAnchor).isActive = true
        d7_title.bottomAnchor.constraint(equalTo: d7_lbl.topAnchor).isActive = true
        d7_title.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: title_width).isActive = true
        d7_title.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: section3_height).isActive = true
        
        d7_up.leadingAnchor.constraint(equalTo: d7_title.trailingAnchor).isActive = true
        d7_up.bottomAnchor.constraint(equalTo: d7_lbl.topAnchor).isActive = true
        d7_up.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: performance_arrows_width).isActive = true
        d7_up.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: section3_height).isActive = true
    }
    
    fileprivate func add_performance_stats() {
        container_view.addSubview(h24_lbl)
        container_view.addSubview(h1_lbl)
        container_view.addSubview(d7_lbl)
        
        h24_lbl.textAlignment = .center
        h1_lbl.textAlignment = .center
        d7_lbl.textAlignment = .center
        
        h24_lbl.style_stock_price_label(font_size: font_size_performance, font_color: .white, autolayout: true)
        h1_lbl.style_stock_price_label(font_size: font_size_performance, font_color: .white, autolayout: true)
        d7_lbl.style_stock_price_label(font_size: font_size_performance, font_color: .white, autolayout: true)
        
        h24_down.translatesAutoresizingMaskIntoConstraints = false
        h1_down.translatesAutoresizingMaskIntoConstraints = false
        d7_down.translatesAutoresizingMaskIntoConstraints = false
        
        container_view.addSubview(h24_down)
        container_view.addSubview(h1_down)
        container_view.addSubview(d7_down)
        
        h24_down.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        h1_down.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        d7_down.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        h24_down.contentMode = .scaleAspectFit
        h1_down.contentMode = .scaleAspectFit
        d7_down.contentMode = .scaleAspectFit
        
        h24_down.tintColor = performance_arrows_color
        h1_down.tintColor = performance_arrows_color
        d7_down.tintColor = performance_arrows_color
        
        let title_width = (1 - (performance_arrows_width * 3)) / 3
        
        h1_lbl.leadingAnchor.constraint(equalTo: container_view.leadingAnchor).isActive = true
        h1_lbl.bottomAnchor.constraint(equalTo: container_view.bottomAnchor).isActive = true
        h1_lbl.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: title_width).isActive = true
        h1_lbl.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: section4_height).isActive = true
        
        h1_down.leadingAnchor.constraint(equalTo: h1_lbl.trailingAnchor).isActive = true
        h1_down.bottomAnchor.constraint(equalTo: container_view.bottomAnchor).isActive = true
        h1_down.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: performance_arrows_width).isActive = true
        h1_down.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: section4_height).isActive = true
        
        h24_lbl.leadingAnchor.constraint(equalTo: h1_down.trailingAnchor).isActive = true
        h24_lbl.bottomAnchor.constraint(equalTo: container_view.bottomAnchor).isActive = true
        h24_lbl.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: title_width).isActive = true
        h24_lbl.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: section4_height).isActive = true
        
        h24_down.leadingAnchor.constraint(equalTo: h24_lbl.trailingAnchor).isActive = true
        h24_down.bottomAnchor.constraint(equalTo: container_view.bottomAnchor).isActive = true
        h24_down.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: performance_arrows_width).isActive = true
        h24_down.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: section4_height).isActive = true
        
        d7_lbl.leadingAnchor.constraint(equalTo: h24_down.trailingAnchor).isActive = true
        d7_lbl.bottomAnchor.constraint(equalTo: container_view.bottomAnchor).isActive = true
        d7_lbl.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: title_width).isActive = true
        d7_lbl.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: section4_height).isActive = true
        
        d7_down.leadingAnchor.constraint(equalTo: d7_lbl.trailingAnchor).isActive = true
        d7_down.bottomAnchor.constraint(equalTo: container_view.bottomAnchor).isActive = true
        d7_down.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: performance_arrows_width).isActive = true
        d7_down.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: section4_height).isActive = true
    }
    
    fileprivate func assign_cell_labels() {
        usd_price_lbl.text = currencyConverter(aDouble: self.crypto?.usd_data.price ?? 0)
        symbol_lbl.text = self.crypto?.symbol
        name_lbl.text = self.crypto?.name
        h1_lbl.text = "\(self.crypto?.usd_data.pct_1h ?? 0)"
        h24_lbl.text = "\(self.crypto?.usd_data.pct_24h ?? 0)"
        d7_lbl.text = "\(self.crypto?.usd_data.pct_1week ?? 0)"
        
        h1_up.tintColor = self.crypto?.usd_data.pct_1h ?? 0.0 > 0.0 ? UIColor.Tendies_color : performance_arrows_color
        h24_up.tintColor = self.crypto?.usd_data.pct_24h ?? 0.0 > 0.0 ? UIColor.Tendies_color : performance_arrows_color
        d7_up.tintColor = self.crypto?.usd_data.pct_1week ?? 0.0 > 0.0 ? UIColor.Tendies_color : performance_arrows_color
        
        h1_down.tintColor = self.crypto?.usd_data.pct_1h ?? 0.0 < 0.0 ? UIColor.No_Tendies_color : performance_arrows_color
        h24_down.tintColor = self.crypto?.usd_data.pct_24h ?? 0.0 < 0.0 ? UIColor.No_Tendies_color : performance_arrows_color
        d7_down.tintColor = self.crypto?.usd_data.pct_1week ?? 0.0 < 0.0 ? UIColor.No_Tendies_color : performance_arrows_color
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
