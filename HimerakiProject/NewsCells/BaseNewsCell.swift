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
    
    let imageView: CachedImageView = {
        let iv = CachedImageView()
        iv.layer.cornerRadius = 15
        return iv
    }()
    
    let headerTitle = UILabel(text: "Header Title", font: UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.medium), numberOfLines: 1, color: .black)
    let mainTitle = UILabel(text: "Main Title", font: UIFont.systemFont(ofSize: 27, weight: UIFont.Weight.bold), numberOfLines: 1, color: .black)
    let subTitle = UILabel(text: "Subtitle Title Subtitle Title Subtitle Title Subtitle Title Subtitle Title Subtitle Title", font: UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.medium), numberOfLines: 0, color: .black)
    
    var disabledHighlightedAnimation = false
    
    func resetTransform() {
        transform = .identity
    }
    
    func freezeAnimations() {
        disabledHighlightedAnimation = true
        layer.removeAllAnimations()
    }
    
    func unfreezeAnimations() {
        disabledHighlightedAnimation = false
    }
    
    // Make it appears very responsive to touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        animate(isHighlighted: true)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        animate(isHighlighted: false)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        animate(isHighlighted: false)
    }
    
    private func animate(isHighlighted: Bool, completion: ((Bool) -> Void)?=nil) {
        if disabledHighlightedAnimation {
            return
        }
        let animationOptions: UIView.AnimationOptions = GlobalConstants.isEnabledAllowsUserInteractionWhileHighlightingCard
            ? [.allowUserInteraction] : []
        if isHighlighted {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.transform = .init(scaleX: GlobalConstants.cardHighlightedFactor, y: GlobalConstants.cardHighlightedFactor)
            }, completion: completion)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: animationOptions, animations: {
                            self.transform = .identity
            }, completion: completion)
        }
    }
    
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
