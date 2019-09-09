//
//  GenerateView.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 04/09/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//

import Foundation
import UIKit

extension generateViewController{
    
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
    
    func createConfirmButton() -> UIButton{
        let button = UIButton()
        button.isEnabled = false
        button.layer.cornerRadius = 15
        button.layer.applySketchShadow(color: .black, alpha: 0.5, x: 0, y: 2, blur: 4, spread: 0)
        button.backgroundColor = .white
        button.setImage(UIImage(named:"yesForModal"), for: .normal)
        button.setImage(UIImage(named:"confirmDisabled"), for: .disabled)
        button.contentMode = .center
        button.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        return button
    }
    
    func applyConstraints(){
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 20), size: CGSize(width: 32, height: 32))
        
        view.addSubview(confirmButton)
        confirmButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
}
