//
//  Time_Picker.swift
//  Lunar
//
//  Created by Daniel Lee on 9/15/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class Time_Picker: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.delegate = self
        self.dataSource = self
        
    }
    
    let font_size_chartoption: CGFloat = 13
    
    var options = [String]()
    
    func set_up(options: Any) {
        if let init_options = options as? [String] {
            self.options = init_options
            self.selectRow(Int(init_options.count/2), inComponent: 0, animated: false)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return options.count
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.frame.height
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return self.frame.width / 4
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view = UIView()
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.font_space_ranger1?.withSize(self.font_size_chartoption)
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.text = options[row]
        
        view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        
        return view
    }

//    optional public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
//
//    optional public func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? // attribute
//
//    optional public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
