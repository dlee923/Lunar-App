//
//  NavBarColorFlip.swift
//  Lunar
//
//  Created by Daniel Lee on 9/25/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

extension HomeDashboard {
    
    // Use didScroll to manage background drape of portfolio graph
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = -scrollView.contentOffset.y + 87
        if offset > 0 {
            background_bottom_anchor?.constant = offset
        }
        
        let offset2 = -scrollView.contentOffset.y - 88
        if offset2 < -(self.portfolio_graph_height * (self.homeVC?.view.frame.height ?? 0)) {
            // insert function to switch color IF color has not been switched
            let trigger = self.is_scrolled_beyond_graph ? true : false
            UIView.animate(withDuration: 0.25) { self.homeVC?.change_navigation_color(is_active: trigger) }
            self.is_scrolled_beyond_graph = true
            
        } else {
            // insert function to switch color IF color has been switched
            let trigger = !self.is_scrolled_beyond_graph ? true : false
            UIView.animate(withDuration: 0.25) { self.homeVC?.change_navigation_color(is_active: trigger) }
            self.is_scrolled_beyond_graph = false
        }
    }
}
