//
//  DetailCells.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 02/09/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//

import Foundation
import UIKit

class DetailCells: BaseCell {
    
    
    // MARK: - Properties
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Animal"
        label.text = label.text?.uppercased()
        label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.medium)
        label.textColor = UIColor.init(red: 255, green: 161, blue: 206)
        return label
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Giraffe"
        label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.medium)
        label.textColor = UIColor.init(red: 234, green: 97, blue: 149)
        return label
    }()
    
    // MARK: - Helper functions
    
    override func setupViews() {
        backgroundColor = .clear
        
        addSubview(categoryLabel)
        categoryLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 97, height: 0))
        
        addSubview(nameLabel)
        nameLabel.anchor(top: topAnchor, leading: categoryLabel.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0), size: CGSize(width: 0, height: 20))
        
    }
    
}
