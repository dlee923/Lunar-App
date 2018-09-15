//
//  DashboardHeaderCell.swift
//  Lunar
//
//  Created by Daniel Lee on 9/3/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class DashboardHeaderCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Theme_color1
    }
    
    let header_label: UILabel = {
        let header_label = UILabel()
        header_label.font = font_share_tech?.withSize(18)
        header_label.textColor = Theme_color3
        header_label.translatesAutoresizingMaskIntoConstraints = false
        return header_label
    }()
    
    let time_picker: UIPickerView = {
        let time_picker = Time_Picker()
        time_picker.set_up(options: ["Day","Week","Month", "Year", "All Time"])
        time_picker.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        time_picker.translatesAutoresizingMaskIntoConstraints = false
        return time_picker
    }()
    
    let conversion_button = Conversion_Button()
    
    func set_up(header_title: String) {
        header_label.text = header_title
        
        self.addSubview(header_label)
        self.addSubview(time_picker)
        self.addSubview(conversion_button)
        
        header_label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        header_label.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        header_label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        header_label.trailingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        let rotation_buffer_y = self.frame.height * 0.25
        
        time_picker.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        time_picker.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        time_picker.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        time_picker.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -rotation_buffer_y).isActive = true
        
        conversion_button.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        conversion_button.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        conversion_button.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        conversion_button.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: rotation_buffer_y).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
