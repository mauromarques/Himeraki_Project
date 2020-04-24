//
//  GradientBtn.swift
//  Harumaki
//
//  Created by Vinicius Leal on 05/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation
import UIKit

class GradientBtn: UIButton {
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    private var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        themeConfig()
    }
    
    convenience init(title: String, enabled: Bool = true, font: UIFont = UIFont(name: "Futura", size: 20.adjusted)!) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.isEnabled = enabled
        self.titleLabel!.font = font
        
        if self.isEnabled == false {
            self.alpha = 0.5
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        themeConfig()
    }
    
    private func themeConfig() {
        
        //titletext
        setTitleColor(.white, for: .normal)
        
        //gradient
        gradientLayer.locations = [0, 1]
        gradientLayer.colors = [UIColor.mediumPink, UIColor.lightPink].map { $0.cgColor }
        gradientLayer.startPoint = CGPoint(x: 1, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = self.frame.height / 2
        setImage(UIImage(named: "+"), for: .normal)
    }
}
