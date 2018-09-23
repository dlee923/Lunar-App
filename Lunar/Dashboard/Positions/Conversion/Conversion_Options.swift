//
//  Conversion_Options.swift
//  Lunar
//
//  Created by Daniel Lee on 9/15/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class Conversion_Options: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.dataSource = self
        self.delegate = self
        
        set_up()
    }
    
    fileprivate func set_up() {
        self.backgroundColor = Theme_color3
        self.isScrollEnabled = false
        for option in Convert_Currencies.all_values {
            self.options.append(option.rawValue)
        }
    }
    
    static let height: CGFloat = 150
    
    var options = [String]()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Conversion_Options.height / CGFloat(options.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "option")
        cell.backgroundColor = Theme_color3
        cell.textLabel?.text = options[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = Fonts.font_space_ranger3?.withSize(15)
        return cell
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
