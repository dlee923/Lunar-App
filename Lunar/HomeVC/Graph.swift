//
//  Graph.swift
//  Lunar
//
//  Created by Daniel Lee on 7/28/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class Graph: UIView {
    
    init(frame: CGRect, history:[Double]) {
        super.init(frame: frame)
        self.history = history
        self.backgroundColor = .white
    }
    
    var history: [Double]?

    // axis dimensions
    var y_axis_max: Double?
    var y_axis_min: Double?
    var y_axis_range: Double?
    
    // graph inset borders
    let border_inset: Double = 5
    
    // graph dimensions
    var y_axis_height: Double?
    var x_axis_width: Double?
    
    lazy var convert_x_point = {(number_in_series: Double) -> Double in
        var x: Double?
        if let x_range = self.x_axis_width, let count = self.history?.count {
            let x_range_visible = x_range - (self.border_inset * 2)
            x = x_range_visible / (Double(count) - 1) * number_in_series + self.border_inset
        }
        return x ?? 0.0
    }
    
    lazy var convert_y_point = {(price: Double) -> Double in
        var y: Double?
        if let y_range = self.y_axis_range, let y_min = self.y_axis_min, let y_height = self.y_axis_height {
            let y_range_visible = y_height - (self.border_inset * 2)
            y = (((price - y_min) / y_range) * y_range_visible) + self.border_inset
        }
        return y ?? 0.0
    }
    
    func y_axis_assignment() {
        self.y_axis_min = self.history?.min()
        self.y_axis_max = self.history?.max()
        if let min = self.y_axis_min, let max = self.y_axis_max {
            self.y_axis_range = max - min
        }
    }
    
    func render_graph() {
        y_axis_assignment()
        
        let shape_layer = CAShapeLayer()
        shape_layer.borderColor = UIColor.yellow.cgColor
        let graph_path = UIBezierPath()
        
        guard let graph_history = self.history else { return }
        
        // add starting point to graph
        graph_path.move(to: CGPoint(x: convert_x_point(0), y: convert_y_point(graph_history.first ?? 0)))
        
        for x in 1..<graph_history.count {
            let point = CGPoint(x: convert_x_point(Double(x)), y: convert_y_point(graph_history[x]))
            graph_path.addLine(to: point)
            print(point)
        }
        
        shape_layer.path = graph_path.cgPath
        shape_layer.lineCap = kCALineCapRound
        shape_layer.lineJoin = kCALineJoinRound
        shape_layer.strokeColor = UIColor.purple.cgColor
        shape_layer.lineWidth = 4.0
        shape_layer.strokeEnd = 1
        shape_layer.fillColor = UIColor.clear.cgColor
        shape_layer.position = CGPoint(x: 0, y: 0)
        
        let stroke_animation = CABasicAnimation(keyPath: "strokeEnd")
        stroke_animation.fromValue = 0
        stroke_animation.toValue = 1
        stroke_animation.duration = 2
        stroke_animation.isRemovedOnCompletion = false
        
        shape_layer.add(stroke_animation, forKey: "strokeEnd")
        
        self.layer.addSublayer(shape_layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
