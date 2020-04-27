//
//  openingViewController.swift
//  HimerakiProject
//
//  Created by Mauro Canhao on 23/04/2020.
//  Copyright © 2020 Mauro Marques. All rights reserved.
//

import UIKit

class openingViewController: UIViewController {
    
    var gradientLayer: CAGradientLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        let iconImage = UIImageView()
        view.addSubview(iconImage)
        iconImage.image = UIImage(named: "animatedCircle")
        iconImage.alpha = 0
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 128))
        iconImage.contentMode = .scaleAspectFit
        iconImage.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive=true
        iconImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        
        let h = UIImageView()
        view.addSubview(h)
        h.image = UIImage(named: "Hicon")
        h.translatesAutoresizingMaskIntoConstraints = false
        h.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: 128))
        h.contentMode = .scaleAspectFit
        h.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive=true
        h.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        
        
        let fluidView = BAFluidView(frame: self.view.frame)
        fluidView.fillDuration = 2
        fluidView.maxAmplitude = 100
        fluidView.fillRepeatCount = 1
        fluidView.fillAutoReverse = false
        fluidView.fillColor = UIColor(red: 254, green: 90, blue: 148)
        fluidView.amplitudeIncrement = 1
        fluidView.lineWidth = 0
        fluidView.fill(to: NSNumber(value: 1.0))
        fluidView.startAnimation()
        self.view.addSubview(fluidView)
        self.view.sendSubviewToBack(fluidView)

//        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//            self.rotate(views: iconImage)
//        })
        self.view.layoutIfNeeded()

        UIView.animate(withDuration: 0.4, delay: 1.8, options: .curveEaseIn, animations: {
            iconImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            iconImage.alpha = 0.5
            self.view.layoutIfNeeded()
        }) { (true) in
            UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseOut, animations: {
                iconImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 2))
                iconImage.alpha = 1
                self.view.layoutIfNeeded()
            }) { (true) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    let newvc = CustomTabController()
                    newvc.modalPresentationStyle = .fullScreen
                    self.navigationController!.present(newvc, animated: false, completion: {
                    })
                }
                
                
            }
        }

    }
    
    func rotate(views: UIView) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 1
        rotation.isCumulative = true
        rotation.repeatCount = 1
        views.layer.add(rotation, forKey: "rotationAnimation")
    }
    
    
    
}
