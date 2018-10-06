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
        self.font = Fonts.font_space_ranger3?.withSize(font_size)
        self.textColor = font_color
    }
    
    func style_stock_name_label(font_size: CGFloat, font_color: UIColor, autolayout: Bool) {
        self.translatesAutoresizingMaskIntoConstraints = autolayout ? false : true
        self.font = Fonts.font_share_tech?.withSize(font_size)
        self.textColor = font_color
    }
    
    func style_stock_price_label(font_size: CGFloat, font_color: UIColor, autolayout: Bool) {
        self.translatesAutoresizingMaskIntoConstraints = autolayout ? false : true
        self.textColor = font_color
        self.font = Fonts.font_share_tech?.withSize(font_size)
    }
    
    func style_stock_usd_price_label(font_size: CGFloat, font_color: UIColor, autolayout: Bool) {
        self.translatesAutoresizingMaskIntoConstraints = autolayout ? false : true
        self.textColor = font_color
        self.font = Fonts.font_spy_agency?.withSize(font_size)
    }
}


class DashboardStockCell: DashboardBaseCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    let roof_border: CGFloat = 5
    let inset_border: CGFloat = 10
    let side_border: CGFloat = 15
    
    let font_size_price_usd: CGFloat = 15
    let font_size_price: CGFloat = 15
    let font_size_symbol: CGFloat = 18
    let font_size_name: CGFloat = 12
    
    let symbol_height_multiplier: CGFloat = 0.4
    let price_height_multiplier: CGFloat = 0.2
    let coin_info_height: CGFloat = 0.5
    let coin_price_height: CGFloat = 1.0
    let graph_height: CGFloat = 0.5
    
    let layout_helper = false
    
    /*
     sections MUST be less than 1.0 to be spaced out correctly
     */
    let section_1_width: CGFloat = 0
    let section_2_width: CGFloat = 0.2
    let section_3_width: CGFloat = 0.4
    let section_4_width: CGFloat = 0.25

    var stock_graph: Graph?
    
    let container_view = UIView()
    let coin_img = UIImageView()
    let symbol_lbl = UILabel()
    let name_lbl = UILabel()
    let price_lbl = UILabel()
    let usd_price_lbl = UILabel()
    let performance_lbl = UIView()
    
    var crypto: Crypto? {
        didSet {
            
        }
    }
    
    func set_up_stock_cell() {
        add_container_view()
        
        add_container_elements()
        
        add_coin_img_constraint()
        
        add_coin_info_constraint()
        
        add_price_info_constraint()
        
        add_graph_view(animate: false)
    }
    
    fileprivate func add_price_info_constraint() {
        usd_price_lbl.style_stock_usd_price_label(font_size: font_size_price_usd, font_color: Colors.Theme_color3, autolayout: true)
        usd_price_lbl.backgroundColor = layout_helper ? .red : .clear
        
        price_lbl.style_stock_price_label(font_size: font_size_price, font_color: .white, autolayout: true)
        price_lbl.backgroundColor = layout_helper ? .red : .clear
        
        usd_price_lbl.bottomAnchor.constraint(equalTo: container_view.centerYAnchor).isActive = true
        usd_price_lbl.leadingAnchor.constraint(equalTo: symbol_lbl.trailingAnchor, constant: inset_border).isActive = true
        usd_price_lbl.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: section_3_width).isActive = true
        usd_price_lbl.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: coin_price_height / 2).isActive = true
        
        price_lbl.topAnchor.constraint(equalTo: container_view.centerYAnchor).isActive = true
        price_lbl.leadingAnchor.constraint(equalTo: symbol_lbl.trailingAnchor, constant: inset_border).isActive = true
        price_lbl.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: section_3_width).isActive = true
        price_lbl.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: coin_info_height / 2).isActive = true
        
        if let crypto_price = crypto?.conversion_data.price {
            price_lbl.text = "\(crypto_price)"
        }
        
        if let usd_price = crypto?.usd_data.price {
            usd_price_lbl.text = "\(currencyConverter(aDouble: usd_price))"
        }
    }
    
    fileprivate func add_coin_info_constraint() {
        symbol_lbl.style_stock_symbol_label(font_size: self.font_size_symbol, font_color: Colors.Theme_color2, autolayout: true)
        symbol_lbl.backgroundColor = layout_helper ? .blue : .clear
        
        name_lbl.style_stock_name_label(font_size: self.font_size_name, font_color: .white, autolayout: true)
        name_lbl.backgroundColor = layout_helper ? .blue : .clear
        
        symbol_lbl.bottomAnchor.constraint(equalTo: container_view.centerYAnchor).isActive = true
        symbol_lbl.leadingAnchor.constraint(equalTo: coin_img.trailingAnchor, constant: inset_border).isActive = true
        symbol_lbl.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: section_2_width).isActive = true
        symbol_lbl.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: coin_info_height / 2).isActive = true
        
        name_lbl.topAnchor.constraint(equalTo: container_view.centerYAnchor).isActive = true
        name_lbl.leadingAnchor.constraint(equalTo: coin_img.trailingAnchor, constant: inset_border).isActive = true
        name_lbl.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: section_2_width).isActive = true
        name_lbl.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: coin_info_height / 2).isActive = true
        
        if let crypto_symbol = crypto?.symbol {
            symbol_lbl.text = "\(crypto_symbol)"
        }
        
        if let crypto_name = crypto?.name {
            name_lbl.text = "\(crypto_name)"
        }
    }
    
    fileprivate func add_coin_img_constraint() {
        if let crypto_symbol = crypto?.symbol {
            if let coin_image = UIImage(named: "\(crypto_symbol.lowercased()).png") {
                coin_img.image = coin_image
            } else {
                coin_img.image = UIImage(named: "act.png")
            }
        }
        
        coin_img.contentMode = .scaleAspectFit
        coin_img.backgroundColor = layout_helper ? .red : .clear
        coin_img.translatesAutoresizingMaskIntoConstraints = false
        
        coin_img.bottomAnchor.constraint(equalTo: container_view.bottomAnchor, constant: -roof_border).isActive = true
        coin_img.topAnchor.constraint(equalTo: container_view.topAnchor, constant: roof_border).isActive = true
        coin_img.leadingAnchor.constraint(equalTo: container_view.leadingAnchor).isActive = true
        coin_img.trailingAnchor.constraint(equalTo: name_lbl.leadingAnchor, constant: -inset_border).isActive = true
    }
    
    fileprivate func add_container_elements() {
        container_view.addSubview(price_lbl)
        container_view.addSubview(symbol_lbl)
        container_view.addSubview(name_lbl)
        container_view.addSubview(coin_img)
        container_view.addSubview(usd_price_lbl)
        container_view.addSubview(performance_lbl)
    }
    
    fileprivate func add_container_view() {
        self.addSubview(container_view)
        container_view.translatesAutoresizingMaskIntoConstraints = false
        container_view.backgroundColor = layout_helper ? .purple : .clear
        
        container_view.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -roof_border).isActive = true
        container_view.topAnchor.constraint(equalTo: self.topAnchor, constant: roof_border).isActive = true
        container_view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: side_border).isActive = true
        container_view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -side_border).isActive = true
    }
    
    fileprivate func add_graph_view(animate: Bool) {
        let empty_price_history: [Double] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        let crypto_history = crypto?.price_history ?? empty_price_history
        
        let graph_width = (self.frame.width - (side_border * 2)) * section_4_width
        let graph_height = (self.frame.height - (roof_border * 2)) * self.graph_height
        
        stock_graph = Graph(frame: CGRect.zero,
                            history: crypto_history,
                            animate: animate)
        
        if let stock_graph_view = stock_graph {
            self.addSubview(stock_graph_view)
            stock_graph_view.translatesAutoresizingMaskIntoConstraints = false
            
            stock_graph_view.centerYAnchor.constraint(equalTo: container_view.centerYAnchor, constant: -CGFloat(stock_graph_view.border_inset * 1.5)).isActive = true
            stock_graph_view.leadingAnchor.constraint(equalTo: usd_price_lbl.trailingAnchor, constant: inset_border).isActive = true
            stock_graph_view.widthAnchor.constraint(equalTo: container_view.widthAnchor, multiplier: section_4_width).isActive = true
            stock_graph_view.trailingAnchor.constraint(equalTo: container_view.trailingAnchor).isActive = true
            stock_graph_view.heightAnchor.constraint(equalTo: container_view.heightAnchor, multiplier: self.graph_height).isActive = true
            
            stock_graph_view.x_axis_width = Double(graph_width)
            stock_graph_view.y_axis_height = Double(graph_height)
            stock_graph_view.render_graph(background_clr: .clear, lineWidth: 2.0)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
