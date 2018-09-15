//
//  Conversion_Button.swift
//  Lunar
//
//  Created by Daniel Lee on 9/15/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class Conversion_Button: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        set_up()
    }
    
    func set_up() {
        self.setTitle("LTC", for: UIControlState.normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = Cell_color
        self.layer.cornerRadius = 5
        self.titleLabel?.font = font_space_ranger3?.withSize(15)
        self.setTitleColor(Theme_color3, for: .normal)
    }
    
    func display_conversion_options() {
        print("convert to?")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
