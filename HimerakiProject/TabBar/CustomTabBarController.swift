//
//  CustomTabBarController.swift
//  mapKit-Pedometer-tabbar
//
//  Created by Vinicius Leal on 03/08/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation
import UIKit

class CustomTabController: UITabBarController {
    
    let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.tintColor = .selectedPink
        tabBar.unselectedItemTintColor = .unselectedPink
        tabBar.backgroundColor = .white
        tabBar.barTintColor = .white
        tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.layer.masksToBounds = false
        tabBar.isTranslucent = true
        tabBar.layer.borderWidth = 0
        tabBar.barStyle = .black
        
        view.bringSubviewToFront(tabBar)
        setupView()
        
        viewControllers = [
            createNavController(viewController: NewsViewController(), title: "News", imageName: "home", offset: -25),
            createNavController(viewController: favoritesViewController(collectionViewLayout: layout), title: "Favorites", imageName: "favorite", offset: 25)
        ]
    }
    
    func setupView() {
        createCurvedView(self.view, nsConstraint: tabBar.topAnchor)
        createCenterButton(self.view, nsConstraint: tabBar.topAnchor)
    }
    
    func createCurvedView(_ view: UIView, nsConstraint: NSLayoutYAxisAnchor) {
        
        let curvedView = CurvedView()
        
        view.insertSubview(curvedView, belowSubview: tabBar)
        curvedView.backgroundColor = .clear
        curvedView.constrainHeight(constant: 54)
        curvedView.constrainWidth(constant: UIScreen.main.bounds.width)
        curvedView.centerXInSuperview()
        curvedView.bottomAnchor.constraint(equalTo: nsConstraint, constant: 6).isActive = true
    }
    
    func createCenterButton(_ view: UIView, nsConstraint: NSLayoutYAxisAnchor) {
        
        let addButton = GradientBtn()
        
        view.addSubview(addButton)
        view.bringSubviewToFront(addButton)
        addButton.constrainHeight(constant: 78)
        addButton.constrainWidth(constant: 78)
        addButton.centerXInSuperview()
        addButton.centerYAnchor.constraint(equalTo: nsConstraint, constant: 0).isActive = true
        addButton.addTarget(self, action: #selector(presentVC), for: .touchUpInside)
    }
    
    fileprivate func createNavController(viewController: UIViewController, title: String, imageName: String, offset: CGFloat) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController)
        
        navController.navigationBar.backgroundColor = .white
        navController.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 123, green: 43, blue: 74)]
        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 123, green: 43, blue: 74)]
//        navController.navigationBar.layer.applySketchShadow(color: .black, alpha: 0.2, x: 0, y: -1, blur: 10, spread: 0)
        navController.navigationBar.shadowImage = UIImage()
        navController.navigationBar.barTintColor = .white
        
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -5, right: 0)
        navController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: offset, vertical: 0)
        
        return navController
    }
    
    @objc func presentVC() {
        let vc = generateViewController(collectionViewLayout: layout)
        vc.modalPresentationStyle = .fullScreen
        vc.tabSelectDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
}

extension CustomTabController: TabBarSelectDelegate {
    
    func getIndex(index: Int) {
        selectedIndex = index
    }
    
}
