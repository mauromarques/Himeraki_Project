//
//  popUpView.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 31/08/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//

import Foundation
import UIKit

extension favoritesViewController {
    
    func createBlurView() {
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0
        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        currentWindow?.addSubview(blurEffectView)
        createDetailsContainer(view: blurEffectView)
        UIView.animate(withDuration: 0.2, animations: {
            self.blurEffectView.alpha=1
        }) { (true) in
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.centerYConstraint.constant = 0
                self.blurEffectView.layoutIfNeeded()
            })
        }
    }
    
    func createDetailsContainer(view:UIVisualEffectView) {
        let card = UIView()
        card.backgroundColor = .clear
        card.translatesAutoresizingMaskIntoConstraints=false
        view.contentView.addSubview(card)
        card.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 267))
        card.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        centerYConstraint = card.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: (view.frame.height/2)+(267/2))
        centerYConstraint.isActive=true
        createDetailsCard(container: card)
    }
    
    func createDetailsCard(container: UIView) {
        let card = UIView()
        card.layer.cornerRadius = 15
        card.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 2, blur: 11, spread: 0)
        card.backgroundColor = .white
        container.addSubview(card)
        card.anchor(top: container.topAnchor, leading: container.leadingAnchor, bottom: nil, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 193))
        createDateLabel(card: card)
        createCloseButton(container: container, card: card)
        createDeleteButton(container: container, card: card)
    }
    
    func createDateLabel(card: UIView) {
        let label = UILabel()
        label.text="26/07/2019"
        label.font = UIFont(name: ".SFUIText-Medium", size: 15)
        label.textColor = UIColor.init(red: 210, green: 188, blue: 198)
        card.addSubview(label)
        label.anchor(top: card.topAnchor, leading: card.leadingAnchor, bottom: nil, trailing: card.trailingAnchor, padding: UIEdgeInsets(top: 17, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 18))
        createPinkLineSeparator(label: label, card: card)
    }
    
    func createPinkLineSeparator(label: UILabel, card: UIView) {
        let line = UIView()
        line.backgroundColor = UIColor.init(red: 255, green: 161, blue: 206)
        line.alpha = 0.7
        card.addSubview(line)
        line.anchor(top: label.bottomAnchor, leading: card.leadingAnchor, bottom: nil, trailing: card.trailingAnchor, padding: UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 10))
        
    }
    
    func createCloseButton(container: UIView, card:UIView) {
        let button = UIButton()
        button.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 2, blur: 11, spread: 0)
        button.layer.cornerRadius = 15
        button.backgroundColor = .white
        button.setImage(UIImage(named: "xForPopUp"), for: .normal)
        container.addSubview(button)
        button.anchor(top: card.bottomAnchor, leading: container.leadingAnchor, bottom: container.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: view.frame.width*0.4396, height: 0))
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

    }
    @objc func buttonAction(sender: UIButton!) {
        UIView.animate(withDuration: 0.3, animations: {
            self.centerYConstraint.constant = (self.view.frame.height/2)+(267/2)
            self.blurEffectView.layoutIfNeeded()
        }) { (true) in
            UIView.animate(withDuration: 0.2, animations: {
                self.blurEffectView.alpha=0
            }, completion: { (true) in
                
            })
        }
    }
    
    func createDeleteButton(container: UIView, card:UIView) {
        let button = UIButton()
        button.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 2, blur: 11, spread: 0)
        button.layer.cornerRadius = 15
        button.backgroundColor = .white
        button.setImage(UIImage(named: "trashForPopUp"), for: .normal)
        container.addSubview(button)
        button.anchor(top: card.bottomAnchor, leading: nil, bottom: container.bottomAnchor, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: view.frame.width*0.43, height: 0))
        
    }
}


//, completion: { (true) in
//
//}
