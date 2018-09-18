//
//  General_Properties.swift
//  Lunar
//
//  Created by Daniel Lee on 7/15/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

let font_simple_tech = UIFont(name: "Simple Tech Bold 02", size: 5)
let font_future_forces = UIFont(name: "Future Forces Condensed Italic", size: 5)
let font_good_times = UIFont(name: "Good Times", size: 5)
let font_space_ranger1 = UIFont(name: "Space Ranger Semi-Italic", size: 5)
let font_space_ranger2 = UIFont(name: "Space Ranger Title Italic", size: 5)
let font_space_ranger3 = UIFont(name: "Space Ranger Title", size: 5)
let font_spy_agency = UIFont(name: "Spy Agency Condensed Italic", size: 5)
let font_share_tech = UIFont(name: "Share Tech", size: 5)

let Theme_color1: UIColor = UIColor(red: 45/255, green: 41/255, blue: 40/255, alpha: 1)  // dark
let Theme_color2: UIColor = UIColor(red: 135/255, green: 197/255, blue: 194/255, alpha: 1)  // sky blue
let Theme_color3: UIColor = UIColor(red: 223/255, green: 210/255, blue: 175/255, alpha: 1)  // khaki

let Cell_color = UIColor.gray.withAlphaComponent(0.1)
let Cell_highlight_color = UIColor.white.withAlphaComponent(0.3)

func currencyConverter(aDouble: Double...) -> String{
    
    var aDoubleTTL: Double = 0
    for x in aDouble {
        aDoubleTTL += x
    }
    
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.usesGroupingSeparator = true
    formatter.locale = NSLocale.current
//    formatter.maximumFractionDigits = 0
    
    let newValue = formatter.string(for: aDoubleTTL)
    return newValue!
}
