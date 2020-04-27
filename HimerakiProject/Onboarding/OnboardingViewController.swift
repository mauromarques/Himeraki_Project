//
//  OnboardingViewController.swift
//  HimerakiProject
//
//  Created by Vinicius Moreira Leal on 27/04/2020.
//  Copyright © 2020 Mauro Marques. All rights reserved.
//

import UIKit

protocol OnboardingChildViewControllerDelegate: class {
    func skipPresentation()
    func goToNextPage(controller: UIViewController)
}

class OnboardingViewController: UIViewController {

    //    MARK: - Properties
    var item: OnboardingItem = .first

    var skipButtonIsHidden: Bool {
        return item.isSkipButtonHidden
    }
    
    weak var delegate: OnboardingChildViewControllerDelegate?

    //    MARK: - Outlets
    lazy var skipButton: UIButton = {
        var button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = self.roundedFont(ofSize: .body, weight: .bold, size: 18)
        button.setTitleColor(UIColor(red: 234 / 255, green: 97 / 255, blue: 149 / 255, alpha: 1.0), for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 19.5
        button.layer.applySketchShadow(color: .black, alpha: 0.2, y: 1, blur: 5)
        button.addTarget(self, action: #selector(didTapSkip), for: .touchUpInside)
        return button
    }()

    var animatedView: OnboardingMainContentView?

    lazy var mainTitle: UILabel = {
        var label = UILabel(
            text: item.message,
            font: self.roundedFont(ofSize: .headline, weight: .bold, size: 30),
            numberOfLines: 1,
            color: UIColor(red: 255 / 255, green: 34 / 255, blue: 119 / 255, alpha: 1.0))
        return label
    }()

    lazy var subTitle: UILabel = {
        var label = UILabel(
            text: item.longMessage,
            font: self.roundedFont(ofSize: .body, weight: .regular, size: 18),
            numberOfLines: 0,
            color: UIColor(red: 149 / 255, green: 53 / 255, blue: 90 / 255, alpha: 1.0))
        return label
    }()


    lazy var forwardButton: UIButton = {
        var button = UIButton()
        button.constrainHeight(constant: 90)
        button.constrainWidth(constant: 90)
        button.layer.cornerRadius = 45
        button.layer.applySketchShadow(color: .black, alpha: 0.23, y: 1, blur: 10)
        button.backgroundColor = item.forwardButtonColor
        button.setImage(UIImage(named: item.forwardButtonImage), for: .normal)
        button.addTarget(self, action: #selector(didTapForward), for: .touchUpInside)
        return button
    }()
    
    lazy var stars: [OnboardingStar] = [.tiny, .small, .medium, .large, .extraLarge]
    
    var starImageViews = [UIImageView]()

    //    MARK: - View Controller Life Cycle
    convenience init(_ item: OnboardingItem) {
        self.init()
        self.item = item
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupViews()
        setupStars()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fadeStarsIn()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        fadeStarsIn()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        fadeStarsOut()
    }

    // MARK: - Helpers
    
    private func fadeStarsIn() {
        fadeStarsOut()
        starImageViews.shuffled().forEach { star in
            UIView.animate(withDuration: 1.0, delay: Double.random(in: 0.4..<1.2), options: .curveEaseIn, animations: {
                star.alpha = 1.0
            }, completion: nil)
        }
    }
    
    private func fadeStarsOut() {
        starImageViews.forEach { star in
            UIView.animate(withDuration: 0.3) {
                star.alpha = 0.0
            }
        }
    }
    
    private func setupViews() {

        let labels = [mainTitle, subTitle]
        labels.forEach { $0.textAlignment = .center }

        view.addSubview(skipButton)
        skipButton.isHidden = skipButtonIsHidden
        skipButton.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            leading: nil,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 20),
            size: CGSize(width: 97, height: 39))

        animatedView = OnboardingMainContentView(item)
        
        view.addSubview(animatedView!)
        view.addSubview(mainTitle)
        view.addSubview(subTitle)
        view.addSubview(forwardButton)

        animatedView!.anchor(
            top: skipButton.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            size: CGSize(width: 0, height: 340))

        mainTitle.anchor(
            top: animatedView?.bottomAnchor,
            leading: nil,
            bottom: nil,
            trailing: nil,
            padding: UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0),
            size: CGSize(width: 0, height: 40))
        mainTitle.centerXInSuperview()

        subTitle.anchor(
            top: mainTitle.bottomAnchor,
            leading: view.leadingAnchor,
            bottom: nil,
            trailing: view.trailingAnchor,
            padding: UIEdgeInsets(top: 20, left: 45, bottom: 0, right: 45))

        forwardButton.anchor(
            top: nil,
            leading: nil,
            bottom: view.bottomAnchor,
            trailing: nil,
            padding: UIEdgeInsets(top: 0, left: 0, bottom: 25, right: 0))
        forwardButton.centerXInSuperview()
    }
    
    func setupStars() {
        stars.enumerated().forEach { (index, star) in
            let imageView = UIImageView()
            imageView.tintColor = star.color
            imageView.alpha = 0.0
            starImageViews.append(imageView)
            
            view.addSubview(imageView)
            imageView.frame = CGRect(
                x: item.starsPositions[index].x,
                y: item.starsPositions[index].y,
                width: star.size.width,
                height: star.size.height)
            
            imageView.image = UIImage(named: star.image)
        }
    }
    
    // MARK: - Actions
    
    @objc func didTapSkip() {
        delegate?.skipPresentation()
    }
    
    @objc func didTapForward() {
        delegate?.goToNextPage(controller: self)
    }
}

fileprivate extension UIViewController {
    func roundedFont(ofSize style: UIFont.TextStyle, weight: UIFont.Weight, size: CGFloat) -> UIFont {

        if #available(iOS 13.0, *) {
            if let descriptor = UIFont.systemFont(ofSize: size, weight: weight).fontDescriptor.withDesign(.rounded) {
                return UIFont(descriptor: descriptor, size: size)
            } else {
                return UIFont.preferredFont(forTextStyle: style)
            }
        } else {
            return UIFont.preferredFont(forTextStyle: style)
        }
    }
}
