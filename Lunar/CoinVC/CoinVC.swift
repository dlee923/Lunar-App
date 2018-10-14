//
//  CoinVC.swift
//  Lunar
//
//  Created by Daniel Lee on 10/6/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class CoinVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        set_up()
        add_blur_view()
    }
    
    let blur_view = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    var cardView: CardView? = CardView()
    
    fileprivate func set_up() {
        self.view.backgroundColor = .clear
        
        guard let cardVw = cardView else { return }
        
        self.view.addSubview(cardVw)
        cardVw.dismissViewController = dismiss_self
        cardVw.layer.cornerRadius = CornerRadius.CoinCard.rawValue
        cardVw.translatesAutoresizingMaskIntoConstraints = false
        cardVw.backgroundColor = UIColor.Theme_color1
        cardVw.translatesAutoresizingMaskIntoConstraints = false
        cardVw.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 75).isActive = true
        cardVw.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        cardVw.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        cardVw.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismiss_self)))
    }
    
    fileprivate func add_blur_view() {
        
        blur_view.alpha = 0
        self.view.insertSubview(blur_view, at: 0)
        blur_view.translatesAutoresizingMaskIntoConstraints = false
        blur_view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        blur_view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        blur_view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        blur_view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.blur_view.alpha = 0.5
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.2) {
            self.blur_view.alpha = 0
        }
    }
    
    @objc fileprivate func dismiss_self() {
        self.cardView?.dismissViewController = nil
        self.dismiss(animated: false) {
            
        }
    }
    
    deinit {
        print("coin vc cleared")
    }
}
