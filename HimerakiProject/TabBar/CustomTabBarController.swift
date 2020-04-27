//
//  CustomTabBarController.swift
//  mapKit-Pedometer-tabbar
//
//  Created by Vinicius Leal on 03/08/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class CustomTabController: UITabBarController {
        
    let secretPassword = "GalinhazinhaMagrinha"
    var tapCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.alpha = 0.0
        
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
            createNavController(viewController: favoritesViewController(collectionViewLayout: UICollectionViewFlowLayout()), title: "Favorites", imageName: "favorite", offset: 25)
        ]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if LaunchChecker(for: CustomTabController.self).isFirstLaunch() {
           presentOnboarding()
        }
    
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseOut, animations: {
            self.view.alpha = 1.0
        }, completion: nil)
        
//      Presents Onboarding every time on debug mode.
//        #if DEBUG
//        presentOnboarding()
//        #endif
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        switch item {
        case tabBar.items![0]:
            tapCount += 1
        case tabBar.items![1]:
            tapCount = 0
        default:
            break
        }
        
        if tapCount == 15 {
            tapCount = 0
            askForPassword()
        }
    
    }
    
    func presentOnboarding() {
        let pages = [OnboardingViewController(.first), OnboardingViewController(.second), OnboardingViewController(.third)]
        let onboarding = PageViewController(pages: pages)
        
        pages.forEach { $0.delegate = onboarding }
        
        onboarding.modalPresentationStyle = .fullScreen
        
        present(onboarding, animated: false)
    }
    
    func askForPassword() {
        
        var inputTextField: UITextField?
        
        //Create the AlertController
        let passwordAlert = UIAlertController(title: "Yaay, it's not a secret anymore 🤭", message: "You unlocked the secret screen of Hirameki 😮, enter password to continue", preferredStyle: .alert)
        
        //Create and add the Cancel action
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        passwordAlert.addAction(cancelAction)
        
        //Create and an option action
        let doneAction = UIAlertAction(title: "Done", style: .default) { action -> Void in
            if inputTextField!.text == self.secretPassword {
                UserDefaults.standard.set(true, forKey: "isAuthor")
                self.dismiss(animated: true, completion: { self.showAlert(title: "Well done!", message: "Restart the app to see the secret button", dismissButtonTitle: "Ok") })
            } else {
                self.dismiss(animated: true, completion: { self.showAlert(title: "Oops🥴", message: "Wrong password", dismissButtonTitle: "Ok")})
            }
        }
        passwordAlert.addAction(doneAction)
        
        passwordAlert.addTextField { textField -> Void in
            inputTextField = textField
            inputTextField?.placeholder = "Password"
            inputTextField?.isSecureTextEntry = true
        }
        
        self.present(passwordAlert, animated: true, completion: nil)
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
        let vc = generateViewController(collectionViewLayout: UICollectionViewFlowLayout())
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
