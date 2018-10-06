//
//  Header_Button.swift
//  Lunar
//
//  Created by Daniel Lee on 9/15/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class Header_Button: UIButton {
    
    init(frame: CGRect, title: String) {
        super.init(frame: frame)
        set_up(title: title)
    }
    
    fileprivate func set_up(title: String) {
        self.setTitle(title, for: UIControlState.normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.Cell_color
        self.layer.cornerRadius = 5
        self.titleLabel?.font = UIFont.font_space_ranger3?.withSize(15)
        self.setTitleColor(UIColor.Theme_color3, for: .normal)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.backgroundColor = UIColor.Cell_highlight_color
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.backgroundColor = UIColor.Cell_color
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.backgroundColor = UIColor.Cell_color
    }
    
    static func add_cancel_background(views: [UIView]) {
        let view = UIView()
        view.backgroundColor = .red
        
        UIApplication.shared.keyWindow?.addSubview(view)
    }
    
    fileprivate func remove_cancel_background() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
