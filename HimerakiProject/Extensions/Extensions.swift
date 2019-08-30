//
//  Extensions.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 30/08/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
extension CALayer {
    
    //Used to apply Shadow with the same attributes found in Sketch.
    func applySketchShadow(
        color: UIColor = .black,
        alpha: Float = 0.5,
        x: CGFloat = 0,
        y: CGFloat = 2,
        blur: CGFloat = 4,
        spread: CGFloat = 0)
    {
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
        } else {
            let dx = -spread
            let rect = bounds.insetBy(dx: dx, dy: dx)
            shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}

extension UITextView {
    func hyperLink(originalText: String, hyperLink: String, urlString: String) {
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.alignment = .left
        paragraphStyle.lineSpacing = 1
        
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
        let fullRange = NSMakeRange(0, attributedOriginalText.length)
        attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: fullRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: 15), range: fullRange)
        attributedOriginalText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.init(red: 123, green: 43, blue: 74), range: fullRange)
        
        self.linkTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.init(red: 255, green: 161, blue: 206),
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font : UIFont(name: ".SFUIText-Bold", size: 15)!,
            NSAttributedString.Key.paragraphStyle : paragraphStyle
        ]
        self.attributedText = attributedOriginalText
    }
}
