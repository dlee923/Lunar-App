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
    
    var cancelled_view: UIView?
    var conversion_option: Conversion_Options?
    
    @objc fileprivate func convert_point(object: UIView) -> CGPoint {
        let point_button_converted = convert(object.bounds, to: self.window)
        return CGPoint(x: point_button_converted.minX, y: point_button_converted.minY)
    }
    
    @objc fileprivate func display_conversion_options() {
        let button_frame = self.frame
        
        add_cancel_background()
        
        let converted_btn_origin = convert_point(object: self)
        let conversion_options_frame = CGRect(x: converted_btn_origin.x, y: converted_btn_origin.y + self.bounds.height + 5, width: button_frame.width, height: Conversion_Options.height)
        conversion_option = Conversion_Options(frame: conversion_options_frame)
        guard let conversion_options = conversion_option else { return }
        guard let window = self.window else { return }
        window.addSubview(conversion_options)
    }
    
    fileprivate func add_cancel_background() {
        cancelled_view = UIView()
        let blur = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        blur.alpha = 0.5
        blur.translatesAutoresizingMaskIntoConstraints = false
        cancelled_view?.addSubview(blur)
        
        guard let cancel_view = cancelled_view else { return }
//        cancel_view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        cancel_view.translatesAutoresizingMaskIntoConstraints = false
        guard let window = self.window else { return }
        window.addSubview(cancel_view)
        
        cancel_view.heightAnchor.constraint(equalTo: window.heightAnchor).isActive = true
        cancel_view.widthAnchor.constraint(equalTo: window.widthAnchor).isActive = true
        cancel_view.centerXAnchor.constraint(equalTo: window.centerXAnchor).isActive = true
        cancel_view.centerYAnchor.constraint(equalTo: window.centerYAnchor).isActive = true
        
        blur.heightAnchor.constraint(equalTo: cancel_view.heightAnchor).isActive = true
        blur.widthAnchor.constraint(equalTo: cancel_view.widthAnchor).isActive = true
        blur.centerXAnchor.constraint(equalTo: cancel_view.centerXAnchor).isActive = true
        blur.centerYAnchor.constraint(equalTo: cancel_view.centerYAnchor).isActive = true
        
        let tap_gesture = UITapGestureRecognizer(target: self, action: #selector(cancel_out))
        cancel_view.addGestureRecognizer(tap_gesture)
    }
    
    @objc fileprivate func cancel_out() {
        cancelled_view?.removeFromSuperview()
        conversion_option?.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
