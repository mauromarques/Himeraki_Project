//
//  generateViewController.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 04/09/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//

import UIKit

protocol TabBarSelectDelegate {
    func getIndex(index: Int)
}

class generateViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var arrayOfCategories = [Category(name: "teste", prompt: "test")]
    
    var tabSelectDelegate: TabBarSelectDelegate?
    
    var confirmButton = UIButton()
    var closeButton = UIButton()
    var gradientLayer: CAGradientLayer!
    var categories = ["Character", "Animal", "Colors", "Actions", "Clothes", "Flowers", "Weapons", "Scenarios"]
    
    let popUpCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
    let blurEffectView = UIVisualEffectView()
    var centerYConstraint = NSLayoutConstraint()
    var popUpCollectionHeight = 18
    
    var isSelected = Bool()
    var numberOfSelections = 0
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
        
        blurEffectView.effect = blurEffect
        
        closeButton = createCloseButton()
        confirmButton = createConfirmButton()
        applyConstraints()

    }
    override func viewWillAppear(_ animated: Bool) {
        createGradientLayer()
    }
    
    
    @objc func closeButtonPressed() {
        print("close button pressed")
        self.dismiss(animated: true, completion: nil)
    }
    @objc func confirmButtonPressed() {
        categoriesToGenerate.removeAll()
        arrayOfCategories.removeAll()
        print("confirm button pressed")
        let selectedCellsIndex = collectionView.indexPathsForSelectedItems?.count
        let selectedCellsIndex2 = collectionView.indexPathsForSelectedItems!
        print("number of selected indexes \(String(describing: selectedCellsIndex))")

        for categorySelected in selectedCellsIndex2 {
            let cell = collectionView.cellForItem(at: categorySelected) as! categoriesCheckBox
            let category = cell.categoryLabel.text
            for categoryModel in categoriesToGetPrompt {
                if categoryModel.name == category {
                    categoriesToGenerate.append(categoryModel)
                }
            }
        }
        print("tutua \(categoriesToGenerate.count)")
        
//        let date = Date()
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.year, .month, .day], from: date)
//        
//        let year =  "\(components.year ?? 1)"
//        let month = "\(components.month ?? 1)"
//        let day = "\(components.day ?? 1)"
//        let dateString = year + "-" + month + "-" + day
//        print ("tutua date \(dateString)")
//        
//        let newFavorite = Favorite(date: Date(dateString), categories: arrayOfCategories)
//        
//        print ("tutua newfavorite \(newFavorite)")
        
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
            let cat = categoriesToGenerate[indexPath.row].name
            myCell.categoryLabel.text = cat
            myCell.categoryLabel.text = myCell.categoryLabel.text?.uppercased()
            
            let number = Int.random(in: 0 ..< categoriesToGenerate[indexPath.row].prompt.count)
            let name = categoriesToGenerate[indexPath.row].prompt[number]
            myCell.nameLabel.text = name
            
            let catiguria = Category(name: cat, prompt: name)
            arrayOfCategories.append(catiguria)
            
            print("tutua categories in cell: \(arrayOfCategories)")
            
            return myCell
        }
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! categoriesCheckBox
        myCell.backgroundColor = .clear
        myCell.categoryLabel.text = categoriesToGetPrompt[indexPath.row].name
        return myCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popUpCollectionView {
            return categoriesToGenerate.count
//            return favoriteForDetails.categories.count
        }
        return categoriesToGetPrompt.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! categoriesCheckBox
        let indexPath2 = collectionView.indexPathsForSelectedItems
        if collectionView == popUpCollectionView {
            
        } else {
            
            if numberOfSelections >= 4 {
                collectionView.deselectItem(at: indexPath, animated: true)
                print("cell was deselected")
                print("cucu4")
                collectionView.shake()

            } else {
                numberOfSelections += 1
                print("cucu1")

                if cell.isSelected == true {
                    cell.checkBoxView.backgroundColor = .white
                    confirmButton.isEnabled = true
                    print("cucu2")

                }
                print("cucu3")
                print("index \(indexPath.row)")
            }
            }
        print("SELECT number of selections \(numberOfSelections), number of selected indexes \(String(describing: indexPath2?.count))")
    }
    
    override func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! categoriesCheckBox
        let indexPath2 = collectionView.indexPathsForSelectedItems
        if cell.checkBoxView.backgroundColor == .clear {
            
        } else {
            if cell.isSelected == false {
                cell.checkBoxView.backgroundColor = .clear
                numberOfSelections -= 1
        }
        }
        print("DESELECT number of selections \(numberOfSelections), number of selected indexes \(String(describing: indexPath2?.count))")
        if indexPath2?.count == 0 {
            confirmButton.isEnabled=false
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

public extension UIView {

    func shake(count : Float = 4,for duration : TimeInterval = 0.3,withTranslation translation : Float = 5) {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}
