//
//  Cell4.swift
//  Harumaki
//
//  Created by Vinicius Leal on 02/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class ArticleCell: BaseNewsCell {
        
    static var identifier: String {
        return String(describing: self)
    }
    
    override func setupViews() {
        super.setupViews()
        
        //All views are added, they need constraints.
        imageView.fillSuperview()
//        imageView.image = #imageLiteral(resourceName: "2015-04-27-1430168806-8034176-how_to_make_money_online")
        
        titleContentView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 240, left: 0, bottom: 0, right: 0))
        titleContentView.backgroundColor = UIColor(white: 1, alpha: 0.9)
        titleContentView.layer.cornerRadius = 15
        titleContentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        headerTitle.text = "ARTICLE CELL"
        headerTitle.anchor(top: titleContentView.topAnchor, leading: titleContentView.leadingAnchor, bottom: nil, trailing: titleContentView.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 18))
        
        mainTitle.anchor(top: titleContentView.topAnchor, leading: titleContentView.leadingAnchor, bottom: nil, trailing: titleContentView.trailingAnchor, padding: UIEdgeInsets(top: 44, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 33))
        mainTitle.textColor = UIColor.init(red: 242, green: 138, blue: 177)
        
        subTitle.anchor(top: nil, leading: titleContentView.leadingAnchor, bottom: titleContentView.bottomAnchor, trailing: titleContentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 22, right: 20), size: CGSize(width: 0, height: 40))
        subTitle.textColor = UIColor.init(red: 112, green: 112, blue: 112)
    }
}
