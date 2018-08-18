//
//  DashboardStockCell.swift
//  Lunar
//
//  Created by Daniel Lee on 7/11/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

extension UILabel {
    
    func style_stock_symbol_label(font_size: CGFloat, font_color: UIColor, autolayout: Bool) {
        self.translatesAutoresizingMaskIntoConstraints = autolayout ? false : true
        self.font = font_good_times?.withSize(font_size)
        self.textColor = font_color
//        self.backgroundColor = .black
    }
    
    func style_stock_price_label(font_size: CGFloat, font_color: UIColor, autolayout: Bool) {
        self.translatesAutoresizingMaskIntoConstraints = autolayout ? false : true
        self.textColor = font_color
        self.font = font_spy_agency?.withSize(font_size)
    }
}

class DashboardStockCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.darkGray
    }
    
    let stock_symbol_lbl = UILabel()
    let stock_price_lbl = UILabel()
    let stock_graph_view = UIView()
    
    var crypto: Crypto?
    let inset_border: CGFloat = 5
    
    let symbol_height_multiplier: CGFloat = 0.2
    let price_height_multiplier: CGFloat = 0.1
    
    func set_up_stock_cell() {
        self.addSubview(stock_symbol_lbl)
        stock_symbol_lbl.style_stock_symbol_label(font_size: 30, font_color: .orange, autolayout: true)
        
        self.addSubview(stock_price_lbl)
        stock_price_lbl.style_stock_price_label(font_size: 18, font_color: .white, autolayout: true)
        
        self.addSubview(stock_graph_view)
        stock_graph_view.translatesAutoresizingMaskIntoConstraints = false
        stock_graph_view.backgroundColor = .black
        
        stock_symbol_lbl.bottomAnchor.constraint(equalTo: stock_price_lbl.topAnchor, constant: -inset_border).isActive = true
        stock_symbol_lbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset_border).isActive = true
        stock_symbol_lbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset_border).isActive = true
        stock_symbol_lbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: symbol_height_multiplier).isActive = true
        
        stock_price_lbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -inset_border).isActive = true
        stock_price_lbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset_border).isActive = true
        stock_price_lbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset_border).isActive = true
        stock_price_lbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: price_height_multiplier).isActive = true
        
        stock_graph_view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -inset_border).isActive = true
        stock_graph_view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: inset_border).isActive = true
        stock_graph_view.bottomAnchor.constraint(equalTo: stock_symbol_lbl.topAnchor).isActive = true
        stock_graph_view.topAnchor.constraint(equalTo: self.topAnchor, constant: inset_border).isActive = true
        
        if let crypto_symbol = crypto?.symbol {
            stock_symbol_lbl.text = "\(crypto_symbol)"
        }
        
        if let crypto_price = crypto?.conversion_data.price {
            stock_price_lbl.text = "\(crypto_price)"
        }
        
        add_graph_view()
    }
    
    func add_graph_view() {
        print("hello 1")
        if let crypto_history = crypto?.price_history {
            print("hello 2")
            let graph = Graph(frame: CGRect(x: 0, y: 0,
                                            width: 100,
                                            height: 200),
                              history: crypto_history,
                              animate: false)
            graph.backgroundColor = .blue
            graph.x_axis_width = Double(stock_graph_view.frame.width)
            graph.y_axis_height = Double(stock_graph_view.frame.height)
            graph.render_graph(lineWidth: 4.0, lineColor: UIColor.purple, duration: 2.0)
            self.stock_graph_view.addSubview(graph)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
