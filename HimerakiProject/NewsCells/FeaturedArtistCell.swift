//
//  Cell2.swift
//  Harumaki
//
//  Created by Vinicius Leal on 02/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class FeaturedArtistCell: BaseNewsCell {
    
    
    static var identifier: String {
        return String(describing: self)
    }
    
    let featuredArtistView = FeaturedArtistView()
    
    let whiteGradient = CAGradientLayer()
    
    override func setupViews() {
        super.setupViews()
        
        addSubview(featuredArtistView)
        
        //All views are added, they need constraints.
        imageView.fillSuperview()
//        imageView.image = #imageLiteral(resourceName: "bomie")
        
        featuredArtistView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, size: CGSize(width: 0, height: 140))
        
        headerTitle.text = "FEATURED ARTIST"
        headerTitle.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 18))
        
        mainTitle.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 44, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 33))
        
        subTitle.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 20, right: 20), size: CGSize(width: 0, height: 40))
        subTitle.textColor = UIColor.init(red: 234, green: 97, blue: 149)
        
        [headerTitle, mainTitle, subTitle].forEach({
            bringSubviewToFront($0)
        })
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        imageView.addGradient(with: whiteGradient, gradientFrame: imageView.bounds, colorSet: [UIColor(white: 1, alpha: 0.0), UIColor(white: 1, alpha: 0.1), UIColor.white], locations: [0,0.2, 1])
    }
}
