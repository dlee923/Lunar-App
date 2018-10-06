//
//  Home_View.swift
//  Lunar
//
//  Created by Daniel Lee on 9/3/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

extension HomeVC {
    
    // MARK: Navigation Bar Color Scheme
    func change_navigation_color(is_active: Bool) {
        if is_active {
            // do nothing
            return
        } else {
            self.title_label.textColor = self.title_label.textColor == UIColor.Theme_color1 ? UIColor.Theme_color2 : UIColor.Theme_color1
            self.navigationController?.navigationBar.backgroundColor = self.navigationController?.navigationBar.backgroundColor == UIColor.Theme_color2 ? UIColor.Theme_color1 : UIColor.Theme_color2
            statusBarView?.backgroundColor = statusBarView?.backgroundColor == UIColor.Theme_color2 ? UIColor.Theme_color1 : UIColor.Theme_color2
        }
    }
    
    // MARK: Home View Functions
    func set_up_home_dashboard() {
        home_dashboard = HomeDashboard()
        home_dashboard.homeVC = self
        self.view.addSubview(home_dashboard)
        
        home_dashboard.add_background()
        
        home_dashboard.translatesAutoresizingMaskIntoConstraints = false
        home_dashboard.topAnchor.constraint(equalTo: self.view.topAnchor, constant: home_dashboard_inset_border).isActive = true
        home_dashboard.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: home_dashboard_inset_border).isActive = true
        home_dashboard.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -home_dashboard_inset_border).isActive = true
        home_dashboard.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    func set_up_navigation(button_size: CGFloat, button_image: UIImage) -> UIBarButtonItem {
        let menu_button_view = UIButton(type: .custom)
        menu_button_view.frame = CGRect(x: 0, y: 0, width: button_size, height: button_size)
        menu_button_view.translatesAutoresizingMaskIntoConstraints = false
        menu_button_view.heightAnchor.constraint(equalToConstant: button_size).isActive = true
        menu_button_view.widthAnchor.constraint(equalToConstant: button_size).isActive = true
        
        menu_button_view.imageView?.contentMode = .scaleAspectFit
        menu_button_view.setImage(button_image.withRenderingMode(.alwaysTemplate), for: .normal)
        menu_button_view.tintColor = UIColor.Theme_color3
        
        menu_button_view.addTarget(self, action: #selector(display_settings), for: .touchUpInside)
        
        let menu_button = UIBarButtonItem(customView: menu_button_view)

        return menu_button
    }
    
    @objc fileprivate func display_settings() {
        !self.is_menu_displayed ? show_settings() : hide_settings()
            
    }
    
    
    fileprivate func show_settings() {
        settings_view = SettingsView()
        if let setting_view = settings_view {
            self.view.addSubview(setting_view)
        }
        
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelStatusBar
        
        settings_view?.translatesAutoresizingMaskIntoConstraints = false
        settings_view?.widthAnchor.constraint(equalToConstant: self.view.frame.width * 0.7).isActive = true
        settings_view?.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.7).isActive = true
        settings_view?.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        settings_view_center = settings_view?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -(self.view.frame.width / 2))
        settings_view_center?.isActive = true
        
        
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.window?.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
            self.view.window?.layer.cornerRadius = CornerRadius.Settings.rawValue
            self.view.window?.clipsToBounds = true
            
            self.settings_view_center?.constant = 0
            self.view.layoutIfNeeded()
            
        }) { (complete) in
            self.is_menu_displayed = true
        }
    }
    
    fileprivate func hide_settings() {
        UIApplication.shared.keyWindow?.windowLevel = UIWindowLevelNormal 
        UIView.animate(withDuration: 0.25, animations: {
            self.settings_view_center?.constant = -(self.view.frame.width / 2)
            self.view.window?.transform = CGAffineTransform.identity
            self.view.layoutIfNeeded()
        }) { (complete) in
            self.settings_view?.removeFromSuperview()
            self.settings_view = nil
            self.is_menu_displayed = false
        }
    }
    
    func set_up_profile(button_size: CGFloat, button_image: UIImage?) -> UIBarButtonItem {
        let menu_button_view = UIButton(type: .custom)
        menu_button_view.backgroundColor = .clear
        menu_button_view.layer.borderColor = UIColor.Theme_color3.cgColor
        menu_button_view.layer.borderWidth = 1
        menu_button_view.frame = CGRect(x: 0, y: 0, width: button_size, height: button_size)
        menu_button_view.translatesAutoresizingMaskIntoConstraints = false
        menu_button_view.heightAnchor.constraint(equalToConstant: button_size).isActive = true
        menu_button_view.widthAnchor.constraint(equalToConstant: button_size).isActive = true
        menu_button_view.layer.cornerRadius = menu_button_view.frame.width / 2.7
        
        menu_button_view.imageView?.contentMode = .scaleAspectFit
        menu_button_view.setImage(button_image?.withRenderingMode(.alwaysTemplate), for: .normal)
        menu_button_view.tintColor = menu_button_view.isSelected ? UIColor.Theme_color3 : UIColor.Theme_color1
        
        let menu_button = UIBarButtonItem(customView: menu_button_view)
        
        return menu_button
    }
    
}
