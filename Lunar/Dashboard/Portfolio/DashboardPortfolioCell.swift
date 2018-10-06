//
//  DashboardPortfolioCell.swift
//  Lunar
//
//  Created by Daniel Lee on 8/19/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

extension UILabel {
    
    func style_portfolio_performance_label(font_size: CGFloat, font_color: UIColor, autolayout: Bool) {
        self.font = Fonts.font_share_tech?.withSize(font_size)
        self.textAlignment = .center
        self.textColor = font_color
        self.translatesAutoresizingMaskIntoConstraints = autolayout
    }
}

class DashboardPortfolioCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        add_portfolio_total()
        add_graph_view(animate: true)
    }
    
    let inset_border: CGFloat = 5
    let portfolio_total_height: CGFloat = 50
    
    var price_history: [Double]?
    var portfolio_graph: Graph?
    var portfolio_total: Double?
    let portfolio_ttl_lbl = UILabel()
    
    fileprivate func add_graph_spacer(portfolio_graph: Graph) {
        let spacer = UIView()
        self.insertSubview(spacer, belowSubview: portfolio_graph)
        spacer.backgroundColor = Colors.Theme_color1
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.topAnchor.constraint(equalTo: portfolio_graph.bottomAnchor, constant: -(inset_border * 3)).isActive = true
        spacer.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        spacer.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        spacer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    fileprivate func add_graph_view(animate: Bool) {
        let empty_price_history: [Double] = [10, 25, 13, 16, 12, 21, 22, 18]
        let crypto_history = self.price_history ?? empty_price_history
        
        let graph_width = self.frame.width
        let graph_height = self.frame.height - (inset_border * 2)
        
        portfolio_graph = Graph(frame: CGRect.zero,
                            history: crypto_history,
                            animate: animate)
        
        if let portfolio_graph_view = portfolio_graph {
            self.addSubview(portfolio_graph_view)
            add_graph_spacer(portfolio_graph: portfolio_graph_view)
            
            portfolio_graph_view.translatesAutoresizingMaskIntoConstraints = false
            
            portfolio_graph_view.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            portfolio_graph_view.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true
            portfolio_graph_view.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
            portfolio_graph_view.topAnchor.constraint(equalTo: self.portfolio_ttl_lbl.bottomAnchor).isActive = true
            
            portfolio_graph_view.x_axis_width = Double(graph_width)
            portfolio_graph_view.y_axis_height = Double(graph_height - portfolio_total_height)
            portfolio_graph_view.render_graph(background_clr: Colors.Theme_color2, lineWidth: 4.0)
            
            
        }
    }
    
    fileprivate func add_portfolio_total() {
        portfolio_ttl_lbl.style_portfolio_performance_label(font_size: 45, font_color: Colors.Theme_color3, autolayout: false)
        portfolio_ttl_lbl.text = "$\(self.portfolio_total ?? 0.01)"
        portfolio_ttl_lbl.backgroundColor = Colors.Theme_color2
        self.addSubview(portfolio_ttl_lbl)
        
        portfolio_ttl_lbl.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        portfolio_ttl_lbl.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        portfolio_ttl_lbl.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        portfolio_ttl_lbl.heightAnchor.constraint(equalToConstant: portfolio_total_height).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
