//
//  NewsViewController.swift
//  HimerakiProject
//
//  Created by Vinicius Leal on 02/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class NewsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let viewModel = NewsViewModel()
        
    init(collectionViewLayout layout: UICollectionViewFlowLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        collectionView.dataSource = viewModel
        collectionView.delegate = self
        
        collectionView.register(ChallengeCell.self, forCellWithReuseIdentifier: ChallengeCell.identifier)
        collectionView.register(FeaturedArtistCell.self, forCellWithReuseIdentifier: FeaturedArtistCell.identifier)
        collectionView.register(SupplyReviewCell.self, forCellWithReuseIdentifier: SupplyReviewCell.identifier)
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.identifier)
        collectionView.register(TipsAndTricksCell.self, forCellWithReuseIdentifier: TipsAndTricksCell.identifier)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("item selected")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = viewModel.items[indexPath.section]
        var size = CGSize(width: UIScreen.main.bounds.width - 40, height: 100)
        
        switch item.type {
        case .challenge:
            size.height = 187
            return size
        case .featuredArtist:
            size.height = 412
            return size
        case .supplyReview:
            size.height = 326
            return size
        case .article:
            size.height = 380
            return size
        case .tipsAndTricks:
            size.height = 206
            return size
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 30, left: 20, bottom: 0, right: 20)
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.preservesSuperviewLayoutMargins = true
    }
}

