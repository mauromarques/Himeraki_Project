//
//  GenerateHeader.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 04/09/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//

import Foundation
import UIKit

class generateHeader: BaseCell {
    
    
    // MARK: - Properties
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Generate"
        label.font = UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.semibold)
        label.textColor = UIColor.white
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.text = "Choose up to 6 categories to generate a random list of inspirations for your art"
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
        label.alpha = 0.8
        label.numberOfLines = 0
        label.textColor = UIColor.white
        return label
    }()
    
    // MARK: - Helper functions
    
    override func setupViews() {
        backgroundColor = .clear
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 0))
        
        addSubview(titleLabel)
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: descriptionLabel.topAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 41))
    }
    
}
