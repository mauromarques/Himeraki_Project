//
//  generateViewController.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 04/09/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//

import UIKit

class generateViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var confirmButton = UIButton()
    var closeButton = UIButton()
    var gradientLayer: CAGradientLayer!
    var categories = ["Character", "Animal", "Colors", "Actions", "Clothes", "Flowers", "Weapons", "Scenarios", "Character", "Animal", "Colors", "Actions", "Clothes", "Flowers", "Weapons", "Scenarios", "Character", "Animal", "Colors", "Actions", "Clothes", "Flowers", "Weapons", "Scenarios"]
    
    let popUpCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    let blurEffectView = UIVisualEffectView()
    var centerYConstraint = NSLayoutConstraint()
    var popUpCollectionHeight = 18
    
    var currentPopUp:UIView?
    var currentIndex = Int()
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavBar()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(categoriesCheckBox.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.backgroundColor = .clear
        collectionView.allowsMultipleSelection = true
        collectionView.isUserInteractionEnabled = true
        collectionView?.register(generateHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeader")
        popUpCollectionView.register(generateHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MyHeader")
        popUpCollectionView.register(DetailCells.self, forCellWithReuseIdentifier: "MyCell")
        
        closeButton = createCloseButton()
        confirmButton = createConfirmButton()
        applyConstraints()

    }
    override func viewWillAppear(_ animated: Bool) {
        createGradientLayer()
    }
    
    
    @objc func closeButtonPressed() {
        print("close button pressed")
    }
    @objc func confirmButtonPressed() {
        print("confirm button pressed")
        createBlurView()

    }
    
    
    func setNavBar (){
        
        title = "Generate"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.view.bounds
        
        gradientLayer.colors = [UIColor.init(red: 255, green: 137, blue: 186).cgColor, UIColor.init(red: 255, green: 204, blue: 228).cgColor]
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == popUpCollectionView {
            return CGSize(width: 334.adjusted, height: 18)
        }
        return CGSize(width: view.bounds.width, height: 44)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        if collectionView == popUpCollectionView {
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! DetailCells
//            myCell.categoryLabel.text = favoriteForDetails.categories[indexPath.row].name
            myCell.categoryLabel.text = myCell.categoryLabel.text?.uppercased()
//            myCell.nameLabel.text = favoriteForDetails.categories[indexPath.row].prompt
            return myCell
        }
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! categoriesCheckBox
        myCell.backgroundColor = .clear
        myCell.categoryLabel.text = categories[indexPath.row]
        return myCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popUpCollectionView {
            return 4
//            return favoriteForDetails.categories.count
        }
        return categories.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == popUpCollectionView {
            
        } else {
        
        let cell = collectionView.cellForItem(at: indexPath) as! categoriesCheckBox
        if cell.isSelected == true {
            cell.checkBoxView.backgroundColor = .white
        }

            print("index \(indexPath.row)")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! categoriesCheckBox
        if cell.isSelected == false {
            cell.checkBoxView.backgroundColor = .clear
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == popUpCollectionView{
            return 10
        }
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == popUpCollectionView{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 30, left: 20, bottom: 84, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if collectionView == popUpCollectionView{
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: view.bounds.width*0.9034, height: 136)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind:
        String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier:
            "MyHeader", for: indexPath) as! generateHeader
        return header
        
    }
}
