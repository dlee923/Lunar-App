//
//  General_Properties.swift
//  Lunar
//
//  Created by Daniel Lee on 7/15/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

extension UIFont {
    static let font_simple_tech = UIFont(name: "Simple Tech Bold 02", size: 5)
    static let font_future_forces = UIFont(name: "Future Forces Condensed Italic", size: 5)
    static let font_good_times = UIFont(name: "Good Times", size: 5)
    static let font_space_ranger1 = UIFont(name: "Space Ranger Semi-Italic", size: 5)
    static let font_space_ranger2 = UIFont(name: "Space Ranger Title Italic", size: 5)
    static let font_space_ranger3 = UIFont(name: "Space Ranger Title", size: 5)
    static let font_spy_agency = UIFont(name: "Spy Agency Condensed Italic", size: 5)
    static let font_share_tech = UIFont(name: "Share Tech", size: 5)
}


extension UIColor {
    static let Cell_color = UIColor.gray.withAlphaComponent(0.1)
    static let Cell_highlight_color = UIColor.white.withAlphaComponent(0.1)
    
    static let Theme_color1: UIColor = UIColor(red: 45/255, green: 41/255, blue: 40/255, alpha: 1)  // dark
    static let Theme_color2: UIColor = UIColor(red: 135/255, green: 197/255, blue: 194/255, alpha: 1)  // sky blue
    static let Theme_color3: UIColor = UIColor(red: 223/255, green: 210/255, blue: 175/255, alpha: 1)  // khaki
    
    static let Tendies_color: UIColor = UIColor(red: 204/255, green: 255/255, blue: 102/255, alpha: 1)
    static let No_Tendies_color: UIColor = UIColor(red: 245/255, green: 113/255, blue: 130/255, alpha: 1)
}

extension Double {
    func convertToUSD() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.locale = NSLocale.current
        //    formatter.maximumFractionDigits = 0
        
        let newValue = formatter.string(for: self)
        return newValue!
    }
}

enum CornerRadius: CGFloat {
    case CoinCard = 30
    case Settings = 20
    case Dashboard_Cells = 15
}
