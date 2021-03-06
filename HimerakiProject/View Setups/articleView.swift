//
//  articleView.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 30/08/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//

import Foundation
import UIKit

extension fullArticleViewController {
    
    func createWeirdTriangle() -> UIImageView {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.applySketchShadow(color: .black, alpha: 0.5, x: 0, y: -2, blur: 15, spread: 0)
        image.image = UIImage(named: "weirdTriangle")
        image.contentMode = .scaleAspectFit
        return image
    }
    
    func createCloseButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 32, height: 32))
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.layer.applySketchShadow(color: .black, alpha: 0.5, x: 0, y: 2, blur: 4, spread: 0)
        button.clipsToBounds = false
        button.backgroundColor = .white
        button.setImage(UIImage(named:"x"), for: .normal)
        button.contentMode = .center
        button.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        return button
    }
    
    func createWhiteGradient() -> UIImageView {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "gradientwhite")
        image.contentMode = .scaleToFill
        image.alpha = 0.8
        return image
    }
    
    func createTextView(textReceived: String) -> UITextView {
        let text = UITextView()
        text.delegate = self
        text.isSelectable = false
        text.isEditable = false
        text.isScrollEnabled = false
        
        text.translatesAutoresizingMaskIntoConstraints = false
        text.backgroundColor = .clear
        
        var attributesGrouped: [NSAttributedString.Key : Any] {
            let paragraphStyle = NSMutableParagraphStyle.init()
            paragraphStyle.alignment = .left
            paragraphStyle.lineSpacing = 1
            
            let attributes: [NSAttributedString.Key : Any] = [
                NSAttributedString.Key.foregroundColor : UIColor.init(red: 123, green: 43, blue: 74),
                NSAttributedString.Key.font : UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.light),
                NSAttributedString.Key.paragraphStyle : paragraphStyle
            ]
            return attributes
        }
        let myAttributedString = NSAttributedString(string: textReceived, attributes: attributesGrouped )
        text.attributedText = myAttributedString
        
        let size = CGSize(width: view.frame.width - 60, height: .infinity)
        
        estimatedSize = text.sizeThatFits(size)
        
        return text
    }
    
    func createLinkTextView(artist: String?, profileLink: String) -> UITextView {
        
        let link = UITextView()
        link.backgroundColor = .clear
        link.translatesAutoresizingMaskIntoConstraints = false
        link.delegate = self
        link.isEditable = false
        link.isScrollEnabled = false
        link.isSelectable = true
        
        
        if artist == nil || artist == "" {
            link.text = ""
        } else {
            
            linkUrl = profileLink

            if collectionViewItemType == .featuredArtist || collectionViewItemType == .supplyReview || collectionViewItemType == .tipsAndTricks {
                
                link.hyperLink(originalText: "Read the full article clicking here", hyperLink: "here", urlString: linkUrl)
                   }
            if collectionViewItemType == .article {
                link.hyperLink(originalText: "Follow \(artist ?? "artist") on Instagram", hyperLink: "Instagram", urlString: linkUrl)
            }
            if collectionViewItemType == .challenge {
                link.hyperLink(originalText: "Participate through our Instagram", hyperLink: "Instagram", urlString: linkUrl)
            }
            
            
        }
        
        return link
    }
    
    func createCategoryLabel() -> UILabel {
        let category = UILabel()
        category.alpha = 0.8
        category.translatesAutoresizingMaskIntoConstraints = false
        category.backgroundColor = .clear
        category.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.medium)
        category.text = "featured artist"
        category.text = category.text?.uppercased()
        category.textColor = .init(red: 151, green: 0, blue: 58)
        category.textAlignment = .left
        return category
    }
    
    func createTitleLabel() -> UILabel {
        let title = UILabel()
        title.alpha = 0.8
        title.translatesAutoresizingMaskIntoConstraints = false
        title.backgroundColor = .clear
        title.font = UIFont.systemFont(ofSize: 27.0, weight: UIFont.Weight.bold)
        title.text = "Park Bom"
        title.textColor = .init(red: 255, green: 161, blue: 206)
        title.textAlignment = .left
        return title
    }
    
    func createBottomContainer() -> UIView {
        let container = UIView()
        container.backgroundColor = .white
        container.clipsToBounds = false
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }
    
    func createShadowContainer() -> UIView {
        let shadow = UIView()
        shadow.backgroundColor = .white
        shadow.clipsToBounds = false
        shadow.translatesAutoresizingMaskIntoConstraints = false
        shadow.layer.applySketchShadow(color: .black, alpha: 0.5, x: 0, y: -2, blur: 15, spread: 0)
        return shadow
    }
    
    func createScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.contentSize.height = estimatedSize.height + Constants.headerHeight + 200
        return scrollView
    }
    
    
    func createHeaderContainerView() -> UIView {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    func createHeaderImageView() -> CachedImageView {
        let imageView = CachedImageView()
        imageView.image = UIImage(named: "bomie")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    func createCreditsLabel() -> UILabel {
        let label = UILabel()
        label.alpha = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 12.0, weight: UIFont.Weight.medium)
        label.text = "Photo by Photographer"
        label.textColor = .init(red: 151, green: 0, blue: 58)
        label.textAlignment = .right
        return label
    }
    
    func createPublisherLabel() -> UILabel {
        let label = UILabel()
        label.alpha = 0.8
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.medium)
        label.text = "Published by: Publisher"
        label.textColor = .init(red: 255, green: 161, blue: 206)
        label.textAlignment = .left
        return label
    }
    
    func arrangeConstraints() {
        let scrollViewConstraints: [NSLayoutConstraint] = [
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(scrollViewConstraints)
        
        headerTopConstraint = headerContainerView.topAnchor.constraint(equalTo: view.topAnchor)
        headerHeightConstraint = headerContainerView.heightAnchor.constraint(equalToConstant: Constants.headerHeight)
        let headerContainerViewConstraints: [NSLayoutConstraint] = [
            headerTopConstraint,
            headerContainerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 1.0),
            headerHeightConstraint
        ]
        NSLayoutConstraint.activate(headerContainerViewConstraints)
        
        let headerImageViewConstraints: [NSLayoutConstraint] = [
            headerImageView.topAnchor.constraint(equalTo: headerContainerView.topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor)
        ]
        NSLayoutConstraint.activate(headerImageViewConstraints)
        
        let bottomContainerConstraints: [NSLayoutConstraint] = [
            bottomContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.headerHeight),
            bottomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainer.heightAnchor.constraint(equalToConstant: estimatedSize.height + 153)
        ]
        NSLayoutConstraint.activate(bottomContainerConstraints)
        
        let shadowContainerConstraints: [NSLayoutConstraint] = [
            shadowContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Constants.headerHeight),
            shadowContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shadowContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shadowContainer.heightAnchor.constraint(equalToConstant: 50)
        ]
        NSLayoutConstraint.activate(shadowContainerConstraints)
        
        let categoryLabelConstraints: [NSLayoutConstraint] = [
            photoCreditsLabel.topAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: 8),
            photoCreditsLabel.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant:  20),
            photoCreditsLabel.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant:  -20),
            photoCreditsLabel.heightAnchor.constraint(equalToConstant: 14)
            
        ]
        NSLayoutConstraint.activate(categoryLabelConstraints)
        
        let photoCreditLabelConstraints: [NSLayoutConstraint] = [
            categoryLabel.topAnchor.constraint(equalTo: photoCreditsLabel.bottomAnchor, constant: 12),
            categoryLabel.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant:  20),
            categoryLabel.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant:  -20),
            categoryLabel.heightAnchor.constraint(equalToConstant: 18)
            
        ]
        NSLayoutConstraint.activate(photoCreditLabelConstraints)
        
        let titleLabelConstraints: [NSLayoutConstraint] = [
            titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant:  20),
            titleLabel.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant:  -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 33)
            
        ]
        NSLayoutConstraint.activate(titleLabelConstraints)
        
        let publisherLabelConstraints: [NSLayoutConstraint] = [
            publisherLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: publisherLabelTopConstant),
            publisherLabel.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant:  20),
            publisherLabel.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant:  -20),
            publisherLabel.heightAnchor.constraint(equalToConstant: publisherLabelHeightConstant)
            
        ]
        NSLayoutConstraint.activate(publisherLabelConstraints)
        
        let textViewConstraints: [NSLayoutConstraint] = [
            textView.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 13),
            textView.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant:  30),
            textView.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant:  -30),
            textView.heightAnchor.constraint(equalToConstant: estimatedSize.height)
            
        ]
        NSLayoutConstraint.activate(textViewConstraints)
        
        let linkTextViewConstraints: [NSLayoutConstraint] = [
            linkTextView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 0),
            linkTextView.leadingAnchor.constraint(equalTo: bottomContainer.leadingAnchor, constant:  30),
            linkTextView.trailingAnchor.constraint(equalTo: bottomContainer.trailingAnchor, constant:  -30),
            linkTextView.heightAnchor.constraint(equalToConstant: 36)
            
        ]
        NSLayoutConstraint.activate(linkTextViewConstraints)
        
        let whiteGradientConstraints: [NSLayoutConstraint] = [
            whiteGradientImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            whiteGradientImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            whiteGradientImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            whiteGradientImageView.heightAnchor.constraint(equalToConstant: 83)
        ]
        NSLayoutConstraint.activate(whiteGradientConstraints)
        
        let closeButtonConstraints: [NSLayoutConstraint] = [
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 32),
            closeButton.widthAnchor.constraint(equalToConstant: 32),

        ]
        NSLayoutConstraint.activate(closeButtonConstraints)
        
        let triangleConstraints: [NSLayoutConstraint] = [
            weirdTriangle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            weirdTriangle.bottomAnchor.constraint(equalTo: bottomContainer.topAnchor, constant: 1),
            weirdTriangle.heightAnchor.constraint(equalToConstant: 30),
            weirdTriangle.widthAnchor.constraint(equalToConstant: 40),
            
            ]
        NSLayoutConstraint.activate(triangleConstraints)
    }
}
