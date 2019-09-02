//
//  favoriteCells.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 30/08/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//

import Foundation
import UIKit

class favoritesCell: BaseCell {
    
    
    // MARK: - Properties
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "26/07/2019"
        label.font = UIFont(name: ".SFUIText-Medium", size: 12)
        label.textColor = UIColor.init(red: 210, green: 188, blue: 198)
        return label
    }()
    
    var categoriesLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = ""
        label.text = label.text?.uppercased()
        label.font = UIFont(name: ".SFUIText-Medium", size: 15)
        label.textColor = UIColor.init(red: 255, green: 161, blue: 206)
        return label
    }()
    
    var previewLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = ""
        label.font = UIFont(name: ".SFUIText-Medium", size: 15)
        label.textColor = UIColor.init(red: 234, green: 97, blue: 149)
        return label
    }()
    
    // MARK: - Helper functions
    
    override func setupViews() {
        backgroundColor = .white
        
        addSubview(dateLabel)
        dateLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 14))
        
        addSubview(categoriesLabel)
        categoriesLabel.anchor(top: dateLabel.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 20))
        
        addSubview(previewLabel)
        previewLabel.anchor(top: categoriesLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20), size: CGSize(width: 0, height: 20))

    }
    
}
