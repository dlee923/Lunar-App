//
//  Graph.swift
//  Lunar
//
//  Created by Daniel Lee on 7/28/18.
//  Copyright © 2018 DLEE. All rights reserved.
//

import UIKit

class Graph: UIView {
    
    init(frame: CGRect, history:[Double], animate: Bool) {
        super.init(frame: frame)
        self.history = history
        self.animate = animate
    }
    
    // graph data
    var history: [Double]?
    
    // graph properties
    var animate: Bool!
    
    let lineColor: UIColor = UIColor.Theme_color3
    let duration: Double = 2.0

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
            let x_range_visible = x_range
            let x_axis_spacing = x_range_visible / (Double(count) - 1)
            x = x_axis_spacing * number_in_series
        }
        return x ?? 0.0
    }
    
    lazy var convert_y_point = {(price: Double) -> Double in
        var y: Double?
        if let y_range = self.y_axis_range, let y_min = self.y_axis_min, let y_height = self.y_axis_height {
            let y_range_visible = y_height - (self.border_inset * 2)
            let y_position = 1 - ((price - y_min) / y_range)
            y = (y_position * y_range_visible) + self.border_inset

        }
        return y ?? 0.0
    }
    
    func y_axis_assignment() {
        self.y_axis_min = self.history?.min()
        self.y_axis_max = self.history?.max()
        if let min = self.y_axis_min, let max = self.y_axis_max {
            let calculated_range = max - min
            if calculated_range == 0 {
                self.y_axis_range = 1
            } else {
                self.y_axis_range = calculated_range
            }
        }
    }
    
    fileprivate func generate_graph(lineWidth: CGFloat, lineColor: UIColor, filled: Bool, background_clr: UIColor) -> CAShapeLayer {
        self.backgroundColor = background_clr
        
        let shape_layer = CAShapeLayer()
        let graph_path = UIBezierPath()
        
        let graph_history = self.history ?? [0]
        
        // add starting point to graph
        graph_path.move(to: CGPoint(x: convert_x_point(0), y: convert_y_point(graph_history.first ?? 0)))
        
        for x in 1..<graph_history.count {
            let point = CGPoint(x: convert_x_point(Double(x)), y: convert_y_point(graph_history[x]))
            graph_path.addLine(to: point)
        }
        
        if filled {
            graph_path.addLine(to: CGPoint(x: convert_x_point(Double(graph_history.count - 1)), y: ((self.y_axis_height ?? 0) + (self.border_inset * 2))))
            graph_path.addLine(to: CGPoint(x: convert_x_point(Double(0)), y: ((self.y_axis_height ?? 0) + (self.border_inset * 2))))
            graph_path.close()
        }
        
        shape_layer.path = graph_path.cgPath
        shape_layer.lineCap = kCALineCapRound
        shape_layer.lineJoin = kCALineJoinRound
        shape_layer.strokeColor = filled ? UIColor.clear.cgColor : lineColor.cgColor
        shape_layer.lineWidth = lineWidth
        shape_layer.strokeEnd = 1
        shape_layer.fillColor = filled ? UIColor.Theme_color1.cgColor : UIColor.clear.cgColor
        shape_layer.position = CGPoint(x: 0, y: 0)
        
        return shape_layer
    }
    
    fileprivate func animate_graph(animated_item: CAShapeLayer, duration: Double) {
        let stroke_animation = CABasicAnimation(keyPath: "strokeEnd")
        stroke_animation.fromValue = 0
        stroke_animation.toValue = 1
        stroke_animation.duration = duration
        stroke_animation.isRemovedOnCompletion = false
        animated_item.add(stroke_animation, forKey: "strokeEnd")
    }
    
    func render_graph(background_clr: UIColor, lineWidth: CGFloat) {
        y_axis_assignment()
        
        let line_graph = generate_graph(lineWidth: lineWidth, lineColor: lineColor, filled: false, background_clr: background_clr)
        let filled_graph = generate_graph(lineWidth: lineWidth, lineColor: lineColor, filled: true, background_clr: background_clr)
        
        if self.animate {
            animate_graph(animated_item: line_graph, duration: duration)
        }
        
        self.layer.addSublayer(filled_graph)
        self.layer.addSublayer(line_graph)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
