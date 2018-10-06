//
//  Watchlist_Button.swift
//  Lunar
//
//  Created by Daniel Lee on 9/18/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class Watchlist_Button: Header_Button {
    
    override init(frame: CGRect, title: String) {
        super.init(frame: frame, title: title)
        set_up()
    }
    
    fileprivate func set_up() {
        self.layer.borderColor = UIColor.Theme_color3.cgColor
        self.layer.borderWidth = 1
        self.addTarget(self, action: #selector(add_coin_to_watch), for: .touchUpInside)
    }
    
    @objc fileprivate func add_coin_to_watch() {
        print("Add coin to watch")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
