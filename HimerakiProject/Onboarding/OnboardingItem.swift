//
//  OnboardingItem.swift
//  HimerakiProject
//
//  Created by Vinicius Moreira Leal on 27/04/2020.
//  Copyright © 2020 Mauro Marques. All rights reserved.
//

import UIKit

enum OnboardingItem {
    case first
    case second
    case third

    var message: String {
        switch self {
        case .first: return "ART PROMPTS"
        case .second: return "WEEKLY CHALLENGES"
        case .third: return "CURATED CONTENT"
        }
    }

    var longMessage: String {
        switch self {
        case .first:
            return "Hira can help you in overcoming art block by generating random art prompts to sparkle your creativity."
        case .second:
            return "Participate in our weekly art challenges and showcase your work for a chance to be featured inside the app."
        case .third:
            return "If you need some inspiration, don’t worry anymore. We make sure to provide updated material to inspire your work."
        }
    }

    var forwardButtonImage: String {
        switch self {
        case .third: return "onb-check-button"
        default: return "onb-forward-button"
        }
    }
    
    var mainImage: String {
        switch self {
        case .first: return "onb-1-main-image"
        case .second: return "onb-2-main-image"
        case .third: return "onb-3-main-image"
        }
    }
    
    var backgroundImage: String {
        switch self {
        case .first: return "onb-1-rect"
        case .second: return "onb-2-rect"
        case .third: return "onb-3-rect"
        }
    }

    var isSkipButtonHidden: Bool {
        switch self {
        case .third: return true
        default: return false
        }
    }

    var gradientViewSidePadding: (left: CGFloat, right: CGFloat) {
        switch self {
        case .first: return (32, 0.0)
        case .second: return (0.0, 0.0)
        case .third: return (0.0, 32)
        }
    }

    var starsPositions: [(x: CGFloat, y: CGFloat)] {
        switch self {
        case .first: return [(329, 414), (108, 184), (179, 205), (289, 270), (68, 305)]
        case .second: return [(348, 427), (272, 202), (88, 359), (56, 262), (299, 372)]
        case .third: return [(86, 427), (128, 233), (204, 163), (298, 305), (36, 279)]
        }
    }
    
    var mainImagePadding: (t: CGFloat, l: CGFloat, b: CGFloat, r: CGFloat) {
        switch self {
        case .first: return (184, 126, 0, 113)
        case .second: return (184, 128, 0, 117)
        case .third: return (102, 66, 0, 44)
        }
    }
}
