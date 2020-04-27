//
//  OnboardingStar.swift
//  HimerakiProject
//
//  Created by Vinicius Moreira Leal on 27/04/2020.
//  Copyright © 2020 Mauro Marques. All rights reserved.
//

import UIKit

enum OnboardingStar {
    case tiny
    case small
    case medium
    case large
    case extraLarge

    var image: String {
        switch self {
        case .tiny: return "onb-inclined-star"
        default: return "onb-regular-star"
        }
    }

    var color: UIColor {
        switch self {
        case .tiny: return UIColor(red: 255 / 255, green: 34 / 255, blue: 119 / 255, alpha: 1.0)
        case .small: return UIColor(red: 117 / 255, green: 6 / 255, blue: 72 / 255, alpha: 1.0)
        case .medium: return UIColor(red: 255 / 255, green: 34 / 255, blue: 119 / 255, alpha: 1.0)
        case .large: return .white
        case .extraLarge: return UIColor(red: 117 / 255, green: 6 / 255, blue: 72 / 255, alpha: 1.0)
        }
    }

    var size: CGSize {
        switch self {
        case .tiny:
            return CGSize(width: 15, height: 15)
        case .small:
            return CGSize(width: 18, height: 21)
        case .medium:
            return CGSize(width: 28, height: 28)
        case .large:
            return CGSize(width: 32, height: 35)
        case .extraLarge:
            return CGSize(width: 39, height: 43)
        }
    }
}
