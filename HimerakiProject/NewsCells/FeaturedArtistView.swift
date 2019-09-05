//
//  FeaturedArtistView.swift
//  Harumaki
//
//  Created by Vinicius Leal on 04/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class FeaturedArtistView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        
        let fillColor = UIColor.init(red: 255, green: 202, blue: 227).withAlphaComponent(0.65)
        
        let path = UIBezierPath()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: self.frame.width, y: 0))
        
        path.addLine(to: CGPoint(x: self.frame.width, y: 50))
        path.addLine(to: CGPoint(x: 0, y: 140))
        
        fillColor.setFill()
        path.close()
        path.fill()
        path.addClip()
        
        self.layer.cornerRadius = 15
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.layer.masksToBounds = true

    }

}
