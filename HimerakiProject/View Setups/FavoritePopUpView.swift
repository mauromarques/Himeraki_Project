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
        dateLabel.text=favoriteForDetails.date.asString(style: .full)
        dateLabel.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.medium)
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
        closeButton.setImage(UIImage(named: "xForPop"), for: .normal)
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
        deleteButton.addTarget(self, action: #selector(deleteAtIndex(sender:)), for: .touchUpInside)
        
    }
    @objc func deleteAtIndex(sender: UIButton!) {
        UIView.animate(withDuration: 0.3, animations: {
            self.centerYConstraint.constant = -(self.view.frame.height/2)-(267/2)
            self.blurEffectView.layoutIfNeeded()
        }) { (true) in
            favorites.remove(at: self.currentIndex)
            let favoritesData = try! JSONEncoder().encode(favorites)
            UserDefaults.standard.set(favoritesData, forKey: "favorites")
            self.collectionView.reloadData()
            if favorites.count == 0 {
                self.nothingToSee.alpha=1
            }
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




































extension generateViewController {
    
    public func createBlurView() {
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0
        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        currentWindow?.addSubview(blurEffectView)
        self.popUpCollectionView.reloadData()
        createDetailsContainer(view: blurEffectView)
        print("cuca after create container \(self.popUpCollectionView.contentSize.height)")
        UIView.animate(withDuration: 0.2, animations: {
            self.blurEffectView.alpha=1
            print("cuca inside animate blur \(self.popUpCollectionView.contentSize.height)")
        }) { (true) in
            print("cuca after animate blur \(self.popUpCollectionView.contentSize.height)")
            self.popUpCollectionHeight = Int(self.popUpCollectionView.contentSize.height)
            self.createDetailsContainer(view: self.blurEffectView)
            self.createPremiumCard(view: self.blurEffectView)
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
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let year =  "\(components.year ?? 1)"
        let month = "\(components.month ?? 1)"
        let day = "\(components.day ?? 1)"
        let dateString = year + "-" + month + "-" + day
        print ("tutua date \(dateString)")
        
        dateLabel.text = Date(dateString).asString(style: .full)
        dateLabel.font = UIFont.systemFont(ofSize: 15.0, weight: UIFont.Weight.medium)
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
        closeButton.setImage(UIImage(named: "xForPop"), for: .normal)
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
        deleteButton.setImage(UIImage(named: "heart"), for: .normal)
        container.addSubview(deleteButton)
        deleteButton.anchor(top: card.bottomAnchor, leading: nil, bottom: container.bottomAnchor, trailing: container.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0), size: CGSize(width: view.frame.width*0.43, height: 0))
        deleteButton.addTarget(self, action: #selector(deleteAtIndex), for: .touchUpInside)
        
    }
    @objc func deleteAtIndex(sender: UIButton!) {
        if favorites.count >= 10 {
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.premiumYConstraint.constant=0
                self.blurEffectView.layoutIfNeeded()
            })
            
        }else{
            
        UIView.animate(withDuration: 0.3, animations: {
            self.centerYConstraint.constant = (self.view.frame.height/2)+(267/2)
            self.blurEffectView.layoutIfNeeded()
        }) { (true) in
            
            let date = Date()
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            
            let year =  "\(components.year ?? 1)"
            let month = "\(components.month ?? 1)"
            let day = "\(components.day ?? 1)"
            let dateString = year + "-" + month + "-" + day
            print ("tutua date \(dateString)")
            
            let newFavorite = Favorite(date: Date(dateString), categories: self.arrayOfCategories)
            favorites.insert(newFavorite, at: 0)
            let favoritesData = try! JSONEncoder().encode(favorites)
            UserDefaults.standard.set(favoritesData, forKey: "favorites")
            
            self.tabSelectDelegate?.getIndex(index: 1)
            
            self.dismiss(animated: true, completion: {
                
            })
            
            print ("tutua newfavorite \(newFavorite)")
            
            UIView.animate(withDuration: 0.2, animations: {
                self.blurEffectView.alpha = 0
            }, completion: { (true) in
                
            })
            }
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
    
    func createPremiumCard(view:UIVisualEffectView){
        let card = UIView()
        card.backgroundColor = .white
        card.layer.cornerRadius = 15
        card.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 2, blur: 11, spread: 0)
        view.contentView.addSubview(card)
        card.translatesAutoresizingMaskIntoConstraints = false
        card.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 346))
        premiumYConstraint = card.centerYAnchor.constraint(equalToSystemSpacingBelow: view.centerYAnchor, multiplier: 0)
        premiumYConstraint.constant = view.frame.height/2 + 173
        premiumYConstraint.isActive = true
        
        createGoPremiumLabel(card: card)
    }
    
    func createGoPremiumLabel(card: UIView){
        
        let goPremium = UILabel()
        goPremium.text="Go premium!"
        goPremium.font = UIFont.systemFont(ofSize: 40, weight: UIFont.Weight.bold)
        goPremium.textColor = UIColor.init(red: 255, green: 34, blue: 119)
        card.addSubview(goPremium)
        goPremium.translatesAutoresizingMaskIntoConstraints=false
        goPremium.anchor(top: card.topAnchor, leading: card.leadingAnchor, bottom: nil, trailing: card.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 48))
        
        createReasonLabel(card: card, premium: goPremium)
    }
    
    func createReasonLabel(card: UIView, premium: UILabel){
        
        let label = UILabel()
        label.text="It seems like you’ve reached the maximum number of favorites."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        label.textColor = UIColor.init(red: 255, green: 161, blue: 206)
        card.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints=false
        label.anchor(top: premium.bottomAnchor, leading: card.leadingAnchor, bottom: nil, trailing: card.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 40))
        
        createFeaturesLabel(card: card, previous: label)
    }
    
    func createFeaturesLabel(card: UIView, previous: UILabel){
        
        let label = UILabel()
        label.text="The premium version includes:"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)
        label.textColor = UIColor.init(red: 255, green: 34, blue: 119)
        card.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints=false
        label.anchor(top: previous.bottomAnchor, leading: card.leadingAnchor, bottom: nil, trailing: card.trailingAnchor, padding: UIEdgeInsets(top: 15, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 14))
        
        createListLabel(card: card, previous: label)
    }
    
    func createListLabel(card: UIView, previous: UILabel){
        
        let label = UILabel()
        label.text="- No ads!\n- Cloud saving!\n- Unlimited storage for favorites.\n- Extra options for ideas generation.\n- Early access to future features."
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.medium)
        label.textColor = UIColor.init(red: 255, green: 161, blue: 206)
        card.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints=false
        label.anchor(top: previous.bottomAnchor, leading: card.leadingAnchor, bottom: nil, trailing: card.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20), size: CGSize(width: 0, height: 100))
        
        createCloseButton2(card: card)
        createShopButton(card: card, previous: label)
    }
    
    func createCloseButton2(card: UIView) {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 32, height: 32))
        button.layer.cornerRadius = 0.5 * button.bounds.size.width
        button.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 2, blur: 4, spread: 0)
        button.clipsToBounds = false
        button.backgroundColor = .white
        button.setImage(UIImage(named:"x"), for: .normal)
        button.contentMode = .center
        button.addTarget(self, action: #selector(closeButtonPressed2), for: .touchUpInside)
        
        card.addSubview(button)
        button.anchor(top: card.topAnchor, leading: nil, bottom: nil, trailing: card.trailingAnchor, padding: UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 10), size: CGSize(width: 32, height: 32))
    }
    
    @objc func closeButtonPressed2() {
        print("champion na shicker gilio")
        UIView.animate(withDuration: 0.3) {
            self.premiumYConstraint.constant = self.view.frame.height/2 + 173
            self.blurEffectView.layoutIfNeeded()
        }
    }
    
    func createShopButton(card: UIView, previous: UILabel) {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 15
        button.backgroundColor = .init(red: 234, green: 97, blue: 149)
        button.setImage(UIImage(named:"shop"), for: .normal)
        button.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(buyButtonPressed), for: .touchUpInside)
        button.isEnabled = false
        
        card.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.anchor(top: previous.bottomAnchor, leading: nil, bottom: card.bottomAnchor, trailing: nil, padding: UIEdgeInsets(top: 30, left: 80, bottom: 20, right: 80), size: CGSize(width: 182, height: 54))
        button.centerXAnchor.constraint(equalTo: card.centerXAnchor).isActive=true
    }
//https://apps.apple.com/tt/app/apollo-explorer/id1465876840
    @objc func buyButtonPressed() {
        print("champion na shicker girilo origio")
       guard let url = URL(string: "https://apps.apple.com/tt/app/apollo-explorer/id1465876840") else { return }
       UIApplication.shared.open(url)
    }
}


//, completion: { (true) in
//
//}
