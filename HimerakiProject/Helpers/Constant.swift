//
//  Constant.swift
//  Harumaki
//
//  Created by Vinicius Leal on 02/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

extension UIColor {
    
    static let selectedPink = UIColor(red:1.00, green:0.63, blue:0.81, alpha:1.0)
    
    static let unselectedPink = UIColor(red:0.82, green:0.74, blue:0.78, alpha:1.0)
    
    static let lightPink = UIColor(red:1.00, green:0.80, blue:0.89, alpha:1.0)
    
    static let mediumPink = UIColor(red:1.00, green:0.54, blue:0.73, alpha:1.0)
}

extension String {
    
    static let bold = ".SFUIText-Bold"
    
    static let medium = ".SFUIText-Medium"
    
    static let regular = ".SFUIText"
}

enum GlobalConstants {
    
    static let cardHighlightedFactor: CGFloat = 0.96
    static let statusBarAnimationDuration: TimeInterval = 0.4
    static let cardCornerRadius: CGFloat = 15
    static let dismissalAnimationDuration = 0.6
    
    static let cardVerticalExpandingStyle: CardVerticalExpandingStyle = .fromTop
    
    
    /// Without this, there'll be weird offset (probably from scrollView) that obscures the card content view of the cardDetailView.
    static let isEnabledWeirdTopInsetsFix = true
    
    /// If true, this will add a 'reverse' additional top safe area insets to make the final top safe area insets zero.
    static let isEnabledTopSafeAreaInsetsFixOnCardDetailViewController = false
    
    /// If true, will always allow user to scroll while it's animated.
    static let isEnabledAllowsUserInteractionWhileHighlightingCard = true
    
}

extension GlobalConstants {
    enum CardVerticalExpandingStyle {
        /// Expanding card pinning at the top of animatingContainerView
        case fromTop
        
        /// Expanding card pinning at the center of animatingContainerView
        case fromCenter
    }
}
