//
//  OnboardingMainContentView.swift
//  HimerakiProject
//
//  Created by Vinicius Moreira Leal on 27/04/2020.
//  Copyright © 2020 Mauro Marques. All rights reserved.
//

import UIKit

class OnboardingMainContentView: UIView {

    //    MARK: - Properties
    var item: OnboardingItem = .first

    let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    let mainImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    convenience init(_ item: OnboardingItem) {
        self.init()
        self.item = item
        
        setupViews(with: item)
        renderViews(with: item)
    }

    //    MARK: - Helpers
    
    private func setupViews(with item: OnboardingItem) {

        addSubview(backgroundImageView)
        backgroundImageView.anchor(
            top: nil,
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor,
            padding: UIEdgeInsets(
                top: 0,
                left: item.gradientViewSidePadding.left,
                bottom: 85,
                right: item.gradientViewSidePadding.right),
                size: CGSize(width: 0, height: 152))

        addSubview(mainImageView)
        mainImageView.anchor(
            top: self.topAnchor,
            leading: self.leadingAnchor,
            bottom: self.bottomAnchor,
            trailing: self.trailingAnchor,
            padding: UIEdgeInsets(
                top: item.mainImagePadding.t,
                left: item.mainImagePadding.l,
                bottom: item.mainImagePadding.b,
                right: item.mainImagePadding.r))
    }
    
    func renderViews(with item: OnboardingItem) {
        mainImageView.image = UIImage(named: item.mainImage)
        backgroundImageView.image = UIImage(named: item.backgroundImage)
    }
}
