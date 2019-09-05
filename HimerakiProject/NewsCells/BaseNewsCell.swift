//
//  BaseNewsCell.swift
//  StellaMcCartney
//
//  Created by Vinicius Leal on 27/08/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation
import UIKit

/// Parent class for cells with initializers.
class BaseNewsCell: UICollectionViewCell {
    
    let titleContentView = UIView(color: .blue, cornerRadius: 0)
    let imageView = UIImageView(image: UIImage(), cornerRadius: 15)
    let headerTitle = UILabel(text: "Header Title", font: UIFont(name: .medium, size: 15)!, numberOfLines: 1, color: .black)
    let mainTitle = UILabel(text: "Main Title", font: UIFont(name: .bold, size: 27)!, numberOfLines: 1, color: .black)
    let subTitle = UILabel(text: "Subtitle Title Subtitle Title Subtitle Title Subtitle Title Subtitle Title Subtitle Title", font: UIFont(name: .medium, size: 15)!, numberOfLines: 0, color: .black)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.cornerRadius = 15
        self.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 2, blur: 15, spread: 0)
        self.layer.masksToBounds = false
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        [imageView, titleContentView, headerTitle, mainTitle, subTitle].forEach({
            addSubview($0)
        })
        
        imageView.backgroundColor = .orange
        headerTitle.textColor = UIColor.init(red: 151, green: 0, blue: 58)
        mainTitle.textColor = .white
        subTitle.textColor = .white
    }
}
