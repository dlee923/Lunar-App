//
//  MenuView.swift
//  Lunar
//
//  Created by Daniel Lee on 7/8/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class MenuView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        
    }
    
    func add_constraints(parent_view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: parent_view.topAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: parent_view.bottomAnchor).isActive = true
        self.trailingAnchor.constraint(equalTo: parent_view.leadingAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: parent_view.widthAnchor, multiplier: 0.2).isActive = true
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
