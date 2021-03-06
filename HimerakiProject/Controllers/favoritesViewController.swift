//
//  ViewController.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 29/08/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//
import UIKit
import GoogleMobileAds

var favorites = [Favorite]()

class favoritesViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
     let adView = GADBannerView()
     
     var favoriteForDetails = Favorite(date: Date("2025-9-30")
          , categories: [Category.init(name: "Animal", prompt: "Monkey"), Category.init(name: "Color", prompt: "Blue & Red")])
    let popUpCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    
    let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
    let blurEffectView = UIVisualEffectView()
    var centerYConstraint = NSLayoutConstraint()
    var popUpCollectionHeight = 18
     
     var currentPopUp:UIView?
     var currentIndex = Int()
    
     let nothingToSee:UILabel={
          var image = UILabel()
          image.text = "There's still nothing to see here"
          image.textAlignment = .center
          image.textColor = .lightGray
          image.alpha = 0.5
          return image
     }()
     
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        favorites.append(contentsOf: [favorite1, favorite2, favorite3, favorite4, favorite5, favorite6, favorite7])
     
        print("\(favorites)")
        
        setNavBar()
        blurEffectView.effect=blurEffect
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(favoritesCell.self, forCellWithReuseIdentifier: "MyCell")
        popUpCollectionView.register(DetailCells.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.backgroundColor = UIColor.white
        setImage()
     
//     setupAd()
    }
     
     func setupAd(){
         
         view.addSubview(adView)
         
         adView.backgroundColor = .clear
         adView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: nil, size: CGSize(width: 320, height: 50))
         adView.translatesAutoresizingMaskIntoConstraints = false
         adView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive=true
         
         adView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
         adView.rootViewController = self
         adView.load(GADRequest())
         adView.delegate = self
         
     }
     
     func setImage(){
          view.addSubview(nothingToSee)
          nothingToSee.translatesAutoresizingMaskIntoConstraints = false
          nothingToSee.anchor(top: nil, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 60, bottom: 0, right: 60), size: CGSize(width: 0, height: 160))
          nothingToSee.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor, constant: 0).isActive=true
     }
    func setNavBar (){
    
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 123, green: 43, blue: 74)]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.init(red: 123, green: 43, blue: 74)]
//        navigationController?.navigationBar.layer.applySketchShadow(color: .black, alpha: 0.2, x: 0, y: -1, blur: 10, spread: 0)
//        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationController?.navigationBar.barTintColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
          if favorites.count == 0 {
               nothingToSee.alpha = 1
          } else {
               nothingToSee.alpha = 0
          }
     }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == popUpCollectionView {
            return CGSize(width: 334.adjusted, height: 18)
        }
        return CGSize(width: view.bounds.width*0.9034, height: 104)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == popUpCollectionView {
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! DetailCells
            myCell.categoryLabel.text = favoriteForDetails.categories[indexPath.row].name
            myCell.categoryLabel.text = myCell.categoryLabel.text?.uppercased()
            myCell.nameLabel.text = favoriteForDetails.categories[indexPath.row].prompt
            return myCell
        }
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath as IndexPath) as! favoritesCell
        myCell.layer.cornerRadius = 15
        myCell.layer.applySketchShadow(color: .black, alpha: 0.3, x: 0, y: 2, blur: 11, spread: 0)
        
        myCell.previewLabel.text = ""
        myCell.categoriesLabel.text = ""

        
        for category in favorites[indexPath.row].categories{
            myCell.categoriesLabel.text = myCell.categoriesLabel.text! + category.name + " | "
            myCell.previewLabel.text = myCell.previewLabel.text! + category.prompt + ", "

        }
        myCell.categoriesLabel.text?.removeLast(2)
        myCell.previewLabel.text?.removeLast(2)
        myCell.previewLabel.text = myCell.previewLabel.text! + "."
        myCell.categoriesLabel.text = myCell.categoriesLabel.text?.uppercased()
        myCell.dateLabel.text = favorites[indexPath.row].date.asString(style: .medium)
        
        return myCell
    }
   
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == popUpCollectionView {
            return favoriteForDetails.categories.count
        }
        return favorites.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     if collectionView == popUpCollectionView {
          
     } else {
          favoriteForDetails = favorites[indexPath.row]
          popUpCollectionView.reloadData()
          print("cuca in didselect \(popUpCollectionView.contentSize.height)")
          print("index \(indexPath.row)")
          currentIndex = indexPath.row
          createBlurView()
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
        //top, left, bottom, right
        if collectionView == popUpCollectionView{
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 10, left: 20, bottom: 50, right: 20)
    }
    
}

extension favoritesViewController: GADBannerViewDelegate {
    
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("ad received")
     
    }
    
    func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
        print(error)
    }
}
