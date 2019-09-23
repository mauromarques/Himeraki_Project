//
//  GradientBtnn.swift
//  daTrue
//
//  Created by Vinicius Leal on 16/08/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont, numberOfLines: Int, color: UIColor) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = color
        self.numberOfLines = numberOfLines
        
    }
}

extension UIView {
    convenience init(color: UIColor, cornerRadius: CGFloat) {
        self.init(frame: .zero)
        self.layer.cornerRadius = cornerRadius
        self.backgroundColor = color
    }
}

extension UIButton {
    static func createButton(imageName: String, height: CGFloat, width: CGFloat) -> UIButton {
        let button = UIButton()
        button.backgroundColor = .white
        button.setImage(UIImage(named: imageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.constrainHeight(constant: height)
        button.constrainWidth(constant: width)
        return button
    }
    
    static func createButtonWithGradient(cornerRadius: CGFloat, height: CGFloat, title: String) -> UIButton {
        let button = UIButton()
        button.tintColor = .white
        button.setTitle(title, for: .normal)
        button.isEnabled = false
        button.constrainHeight(constant: height)
        button.layer.cornerRadius = cornerRadius
        button.layer.masksToBounds = true
        return button
    }
}

extension UIView {
    func addGradient(with layer: CAGradientLayer, gradientFrame: CGRect? = nil, colorSet: [UIColor],
                     locations: [Double], startEndPoints: (CGPoint, CGPoint)? = nil) {
        layer.frame = gradientFrame ?? self.bounds
        layer.anchorPoint = CGPoint(x: gradientFrame!.minX, y: gradientFrame!.minY)
        layer.cornerRadius = 7
        
        let layerColorSet = colorSet.map { $0.cgColor }
        let layerLocations = locations.map { $0 as NSNumber }
        
        layer.colors = layerColorSet
        layer.locations = layerLocations
        
        if let startEndPoints = startEndPoints {
            layer.startPoint = startEndPoints.0
            layer.endPoint = startEndPoints.1
        }
        
        self.layer.insertSublayer(layer, above: self.layer)
    }
}
