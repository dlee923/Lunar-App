//
//  Conversion_Button.swift
//  Lunar
//
//  Created by Daniel Lee on 9/18/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class Conversion_Button: Header_Button {
    
    override init(frame: CGRect, title: String) {
        super.init(frame: frame, title: title)
        set_up()
    }
    
    func set_up() {
        self.addTarget(self, action: #selector(display_conversion_options), for: .touchUpInside)
    }
    
    @objc func display_conversion_options() {
        let conversion_btn_origin = self.frame
        let conversion_options = Conversion_Options(frame: CGRect(x: conversion_btn_origin.origin.x, y: conversion_btn_origin.origin.y, width: conversion_btn_origin.width, height: Conversion_Options.height))
        guard let home_vc = self.window else { return }
        home_vc.addSubview(conversion_options)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
