//
//  kkkkkViewController.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 29/08/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//

import UIKit

class fullArticleViewController: UIViewController, UITextViewDelegate {

    struct Constants {
        static let headerHeight: CGFloat = 404
    }
    
    // MARK: - Properties
    var linkUrl = String()
    var artistName = "Park Bom"
    
    var scrollView: UIScrollView!
    var headerContainerView: UIView!
    var headerImageView: UIImageView!
    var headerTopConstraint: NSLayoutConstraint!
    var headerHeightConstraint: NSLayoutConstraint!
    var bottomContainer: UIView!
    var categoryLabel: UILabel!
    var titleLabel: UILabel!
    var textView: UITextView!
    var linkTextView: UITextView!
    var shadowContainer: UIView!
    var whiteGradientImageView: UIImageView!
    var estimatedSize: CGSize!
    var closeButton: UIButton!
    var weirdTriangle: UIImageView!

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weirdTriangle = createWeirdTriangle()
        closeButton = createCloseButton()
        linkTextView = createLinkTextView()
        whiteGradientImageView = createWhiteGradient()
        shadowContainer = createShadowContainer()
        textView = createTextView()
        categoryLabel = createCategoryLabel()
        titleLabel = createTitleLabel()
        bottomContainer = createBottomContainer()
        scrollView = createScrollView()
        headerContainerView = createHeaderContainerView()
        headerImageView = createHeaderImageView()
        
        headerContainerView.addSubview(headerImageView)
        scrollView.addSubview(headerContainerView)
        scrollView.addSubview(shadowContainer)
        scrollView.addSubview(weirdTriangle)
        scrollView.addSubview(bottomContainer)
        bottomContainer.addSubview(categoryLabel)
        bottomContainer.addSubview(titleLabel)
        bottomContainer.addSubview(textView)
        bottomContainer.addSubview(linkTextView)
        view.addSubview(scrollView)
        view.addSubview(whiteGradientImageView)
        view.addSubview(closeButton)
        
        arrangeConstraints()
    }
    
    @objc func closeButtonPressed() {
        print("close button pressed")
        self.dismiss(animated: true, completion: nil)
    }
}

extension fullArticleViewController {
    
    internal func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if (URL.absoluteString == linkUrl) {
            UIApplication.shared.open(URL)
        }
        return false
    }
    
}

extension fullArticleViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0.0 {
            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
        } else {
            let parallaxFactor: CGFloat = 0.25
            let offsetY = scrollView.contentOffset.y * parallaxFactor
            let minOffsetY: CGFloat = 8.0
            let availableOffset = min(offsetY, minOffsetY)
            let contentRectOffsetY = availableOffset / Constants.headerHeight
            headerTopConstraint?.constant = view.frame.origin.y
            headerHeightConstraint?.constant = Constants.headerHeight - scrollView.contentOffset.y
            headerImageView.layer.contentsRect = CGRect(x: 0, y: -contentRectOffsetY, width: 1, height: 1)
        }
    }
}

