//
//  ViewController.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 29/08/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//
import UIKit
class favoritesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    let blurEffectView = UIVisualEffectView()
    var centerYConstraint = NSLayoutConstraint()
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBar()
        blurEffectView.effect=blurEffect

//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        //        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//        //        layout.itemSize = CGSize(width: view.bounds.width*0.9034, height: 104)
//        layout.minimumLineSpacing = 15
        
//        let myCollectionView:UICollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(favoritesCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.backgroundColor = UIColor.white
//        self.view.addSubview(myCollectionView)
    }
    
    func setNavBar (){
    
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 123, green: 43, blue: 74)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 123, green: 43, blue: 74)]
        navigationController?.navigationBar.layer.applySketchShadow(color: .black, alpha: 0.2, x: 0, y: -1, blur: 10, spread: 0)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barTintColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.bounds.width*0.9034, height: 104)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! favoritesCell
        myCell.layer.cornerRadius = 15
        myCell.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 2, blur: 11, spread: 0)
//        myCell.backgroundColor = UIColor.white
        return myCell
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("index \(indexPath.row)")
        createBlurView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //top, left, bottom, right
        return UIEdgeInsets(top: 30, left: 20, bottom: 30, right: 20)
    }
    
}
