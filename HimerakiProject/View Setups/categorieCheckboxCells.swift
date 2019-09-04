//
//  categorieCheckboxCells.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 04/09/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//

import Foundation
import UIKit

class categoriesCheckBox: BaseCell {
    
    
    // MARK: - Properties
    
    var checkBoxView: UIView = {
        let checkBox = UIView()
       checkBox.layer.borderWidth = 2
        checkBox.layer.borderColor = UIColor.white.cgColor
        checkBox.layer.cornerRadius = 8
        checkBox.backgroundColor = .clear
        return checkBox
    }()
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Animal"
        label.font = UIFont(name: ".SFUIText-Bold", size: 16)
        label.textColor = UIColor.white
        return label
    }()
    
    // MARK: - Helper functions
    
    override func setupViews() {
        backgroundColor = .clear
        
        addSubview(checkBoxView)
        checkBoxView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0), size: CGSize(width: 44, height: 0))
        
        addSubview(categoryLabel)
        categoryLabel.anchor(top: topAnchor, leading: checkBoxView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0), size: CGSize(width: 0, height: 0))
        
    }
    
}
