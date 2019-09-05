//
//  NewsViewController.swift
//  HimerakiProject
//
//  Created by Vinicius Leal on 02/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import UIKit

class NewsViewController: UICollectionViewController {

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
        collectionView.delegate = viewModel
        
        collectionView.register(ChallengeCell.self, forCellWithReuseIdentifier: ChallengeCell.identifier)
        collectionView.register(FeaturedArtistCell.self, forCellWithReuseIdentifier: FeaturedArtistCell.identifier)
        collectionView.register(SupplyReviewCell.self, forCellWithReuseIdentifier: SupplyReviewCell.identifier)
        collectionView.register(ArticleCell.self, forCellWithReuseIdentifier: ArticleCell.identifier)
        collectionView.register(TipsAndTricksCell.self, forCellWithReuseIdentifier: TipsAndTricksCell.identifier)
        
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    }
    
}

