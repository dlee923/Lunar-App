//
//  CardView.swift
//  Lunar
//
//  Created by Daniel Lee on 10/14/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var viewOrigin: CGPoint?
    var viewPosition: CGPoint?
    var dismissTarget: CGFloat?
    var dismissViewController: (() -> ())?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.viewOrigin = self.center
        self.viewPosition = touches.first?.location(in: self.superview)
        dismissTarget = (self.superview?.bounds.height ?? 0)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self.superview)
            let originalYChange = position.y - (self.viewPosition?.y)!
            let newYCoordinate = (self.viewOrigin?.y)! + originalYChange
            self.center = CGPoint(x: self.center.x, y: newYCoordinate)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let currentYPosition = self.center.y
        print(currentYPosition)
        print(dismissTarget ?? 0)
        if currentYPosition > (dismissTarget ?? 0) {
            print("dismiss")
            self.dismissViewController!()
        }
        else {
            self.center = self.viewOrigin ?? CGPoint.zero
        }
    }
    
    deinit {
        print("card removed")
    }
}
