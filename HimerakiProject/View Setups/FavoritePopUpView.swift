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
    
    public func createBlurView() {
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0
        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        currentWindow?.addSubview(blurEffectView)
        createDetailsContainer(view: blurEffectView)
        print("cuca after create container \(self.popUpCollectionView.contentSize.height)")
        UIView.animate(withDuration: 0.2, animations: {
            self.blurEffectView.alpha=1
            print("cuca inside animate blur \(self.popUpCollectionView.contentSize.height)")
        }) { (true) in
            print("cuca after animate blur \(self.popUpCollectionView.contentSize.height)")
            self.popUpCollectionHeight = Int(self.popUpCollectionView.contentSize.height)
            self.createDetailsContainer(view: self.blurEffectView)
            self.blurEffectView.layoutIfNeeded()
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.centerYConstraint.constant = 0
                self.blurEffectView.layoutIfNeeded()
                print("cuca after layout \(self.popUpCollectionView.contentSize.height)")

            })
        }
    }
    
    func createDetailsContainer(view:UIVisualEffectView) {
        let detailsContainer = UIView()
        currentPopUp = detailsContainer
        detailsContainer.backgroundColor = .clear
        detailsContainer.translatesAutoresizingMaskIntoConstraints=false
        view.contentView.addSubview(detailsContainer)
        detailsContainer.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: Int(popUpCollectionHeight + 165)))
        detailsContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
        centerYConstraint = detailsContainer.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: (view.frame.height/2)+CGFloat(((popUpCollectionHeight+165)/2)))
        centerYConstraint.isActive=true
        createDetailsCard(container: detailsContainer)
    }
    
    func createDetailsCard(container: UIView) {
        let card = UIView()
        card.layer.cornerRadius = 15
        card.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 2, blur: 11, spread: 0)
        card.backgroundColor = .white
        container.addSubview(card)
        card.anchor(top: container.topAnchor, leading: container.leadingAnchor, bottom: nil, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: popUpCollectionHeight+91))
        createDateLabel(card: card)
        createCloseButton(container: container, card: card)
        createDeleteButton(container: container, card: card)
    }
    
    func createDateLabel(card: UIView) {
        let dateLabel = UILabel()
        dateLabel.text="26/07/2019"
        dateLabel.font = UIFont(name: ".SFUIText-Medium", size: 15)
        dateLabel.textColor = UIColor.init(red: 210, green: 188, blue: 198)
        card.addSubview(dateLabel)
        dateLabel.anchor(top: card.topAnchor, leading: card.leadingAnchor, bottom: nil, trailing: card.trailingAnchor, padding: UIEdgeInsets(top: 17, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 18))
        createPinkLineSeparator(label: dateLabel, card: card)
    }
    
    func createPinkLineSeparator(label: UILabel, card: UIView) {
        let line = UIView()
        line.backgroundColor = UIColor.init(red: 255, green: 161, blue: 206)
        line.alpha = 0.7
        card.addSubview(line)
        line.anchor(top: label.bottomAnchor, leading: card.leadingAnchor, bottom: nil, trailing: card.trailingAnchor, padding: UIEdgeInsets(top: 6, left: 0, bottom: 0, right: 0), size: CGSize(width: 0, height: 10))
        createPopUpCollection(card: card, line: line)
    }
    
    func createCloseButton(container: UIView, card:UIView) {
        let closeButton = UIButton()
        closeButton.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 2, blur: 11, spread: 0)
        closeButton.layer.cornerRadius = 15
        closeButton.backgroundColor = .white
        closeButton.setImage(UIImage(named: "xForPopUp"), for: .normal)
        container.addSubview(closeButton)
        closeButton.anchor(top: card.bottomAnchor, leading: container.leadingAnchor, bottom: container.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: view.frame.width*0.4396, height: 0))
        closeButton.addTarget(self, action: #selector(dismissPopUp), for: .touchUpInside)

    }
    @objc func dismissPopUp(sender: UIButton!) {
        UIView.animate(withDuration: 0.3, animations: {
            self.centerYConstraint.constant = (self.view.frame.height/2)+(267/2)
            self.blurEffectView.layoutIfNeeded()
        }) { (true) in
            UIView.animate(withDuration: 0.2, animations: {
                self.blurEffectView.alpha = 0
            }, completion: { (true) in
                self.currentPopUp!.removeFromSuperview()
                self.currentPopUp = nil
            })
        }
    }
    
    func createDeleteButton(container: UIView, card:UIView) {
        let deleteButton = UIButton()
        deleteButton.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 2, blur: 11, spread: 0)
        deleteButton.layer.cornerRadius = 15
        deleteButton.backgroundColor = .white
        deleteButton.setImage(UIImage(named: "trashForPopUp"), for: .normal)
        container.addSubview(deleteButton)
        deleteButton.anchor(top: card.bottomAnchor, leading: nil, bottom: container.bottomAnchor, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: view.frame.width*0.43, height: 0))
        deleteButton.addTarget(self, action: #selector(deleteAtIndex), for: .touchUpInside)
        
    }
    @objc func deleteAtIndex(sender: UIButton!) {
        UIView.animate(withDuration: 0.3, animations: {
            self.centerYConstraint.constant = -(self.view.frame.height/2)-(267/2)
            self.blurEffectView.layoutIfNeeded()
        }) { (true) in
            self.favorites.remove(at: self.currentIndex)
            self.collectionView.reloadData()
            UIView.animate(withDuration: 0.2, animations: {
                self.blurEffectView.alpha = 0
            }, completion: { (true) in
                self.currentPopUp!.removeFromSuperview()
                self.currentPopUp = nil
            })
        }
    }
    
    
    func createPopUpCollection(card: UIView, line: UIView){
    card.addSubview(popUpCollectionView)
        popUpCollectionView.delegate = self
        popUpCollectionView.dataSource = self
        popUpCollectionView.backgroundColor = .clear
        popUpCollectionView.isUserInteractionEnabled = false
        popUpCollectionView.clipsToBounds = false
        print("cuca before anchor \(popUpCollectionView.contentSize.height)")
        popUpCollectionView.anchor(top: line.bottomAnchor, leading: card.leadingAnchor, bottom: card.bottomAnchor, trailing: card.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        print("cuca after anchor \(popUpCollectionView.contentSize.height)")

    }
    
}


//, completion: { (true) in
//
//}
