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
    
    @objc func openAirtable(sender: UIButton!) {
        print ("BOSTANARO")
        guard let url = URL(string:"https://airtable.com/shrB8xN4EfYmdbOfW") else { return }
        UIApplication.shared.open(url)
    }
    
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
    
    var infoButton: UIButton = {
        let button = MyButton()
        button.backgroundColor = .clear
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 2
        button.setTitle("i", for: .normal)
        button.setTitleColor(.lightGray, for: .highlighted)
        button.addTarget(self, action: #selector(openAirtable), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Helper functions
    
    override func setupViews() {
        backgroundColor = .clear
        self.isUserInteractionEnabled = true
        
        addSubview(descriptionLabel)
        descriptionLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 0))
        
        addSubview(titleLabel)
        titleLabel.anchor(top: nil, leading: leadingAnchor, bottom: descriptionLabel.topAnchor, trailing: nil, padding: UIEdgeInsets(top: 8, left: 20, bottom: 0, right: 20), size: CGSize(width: 155, height: 41))
        
        addSubview(infoButton)
        infoButton.anchor(top: titleLabel.topAnchor, leading: titleLabel.trailingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets(top: 11, left: 0, bottom: 0, right: 20), size: CGSize(width: 20, height: 20))
        
        self.bringSubviewToFront(infoButton)
    }
    
}

 class MyButton: UIButton
{
    override var isHighlighted: Bool {
        didSet {
            switch isHighlighted {
            case true:
                layer.borderColor = UIColor.lightGray.cgColor
                layer.borderWidth = 2
            case false:
                layer.borderColor = UIColor.white.cgColor
                layer.borderWidth = 2
            }
        }
    }
}
