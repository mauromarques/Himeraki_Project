//
//  CurvedView.swift
//  Harumaki
//
//  Created by Vinicius Leal on 05/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation
import UIKit

class CurvedView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        createPathCircle()
        
        self.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: -1, blur: 11, spread: 0)
        
    }
    
    private func createPathCircle() {
        
        let fillColor: UIColor = .white
        let radius: CGFloat = 49.0
        let path = UIBezierPath()
        let centerWidth = self.frame.width / 2
        let initialHeight = self.frame.height - 5
        
        path.move(to: CGPoint(x: 0, y: initialHeight))
        path.addLine(to: CGPoint(x: (centerWidth - radius * 2), y: initialHeight))
        
        path.addArc(withCenter: CGPoint(x: centerWidth, y: initialHeight), radius: radius, startAngle: CGFloat(180).degressToRadians, endAngle: CGFloat(360).degressToRadians, clockwise: true)
        
        path.addLine(to: CGPoint(x: self.frame.width, y: initialHeight))
        path.addLine(to: CGPoint(x: self.frame.width, y: self.frame.height + 5))
        path.addLine(to: CGPoint(x: 0, y: self.frame.height + 5))
        
        path.close()
        path.usesEvenOddFillRule = true
        fillColor.setFill()
        path.fill()
    }
}
