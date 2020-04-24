//
//  Cell5.swift
//  Harumaki
//
//  Created by Vinicius Leal on 02/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class TipsAndTricksCell: BaseNewsCell {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    var new: News? {
        didSet {
            guard let new = new else { return }
            guard let url = new.pictureUrl else { return }
            
            imageView.loadImage(urlString: url)
            
            headerTitle.text = setHeaderTitle(new)
            mainTitle.text = new.title
            subTitle.text = new.subtitle
        }
    }
    
    let pinkGradient = CAGradientLayer()
    let bottomPink = UIColor.init(red: 255, green: 137, blue: 193)
    
    override func setupViews() {
        super.setupViews()
        
        //All views are added, they need constraints.
        imageView.fillSuperview()
        imageView.applyBlur()
                
        headerTitle.text = "TIPS & TRICKS"
        headerTitle.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 18))
        headerTitle.textColor = UIColor.init(red: 149, green: 53, blue: 90)
        
        mainTitle.anchor(top: nil, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 48, right: 20), size: CGSize(width: 0, height: 33))
        
        subTitle.anchor(top: mainTitle.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20), size: CGSize(width: 0, height: 0))
        subTitle.numberOfLines = 0
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        pinkGradient.opacity = 0.7
        imageView.addGradient(with: pinkGradient, gradientFrame: imageView.bounds, colorSet: [.white, bottomPink], locations: [0, 1])
    }
}

