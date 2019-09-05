//
//  Cell3.swift
//  Harumaki
//
//  Created by Vinicius Leal on 02/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class SupplyReviewCell: BaseNewsCell {
    
    let label3 = UILabel()
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func setupViews() {
        super.setupViews()
        
        //All views are added, they need constraints.
        titleContentView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 59), size: CGSize(width: 0, height: 97))
        titleContentView.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 2, blur: 11, spread: 0)
        titleContentView.layer.cornerRadius = 15
        titleContentView.backgroundColor = .white
        
        imageView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 19, left: 26, bottom: 0, right: 0))
//        imageView.image = #imageLiteral(resourceName: "winsor-newoton-watercolor-markers-twin-tip.1541082645")
        
        headerTitle.text = "SUPPLY REVIEW"
        headerTitle.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 18))
        
        mainTitle.anchor(top: titleContentView.topAnchor, leading: titleContentView.leadingAnchor, bottom: nil, trailing: titleContentView.trailingAnchor, padding: UIEdgeInsets(top: 44, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 33))
        mainTitle.textColor = UIColor.init(red: 241, green: 150, blue: 184)
    }
}
