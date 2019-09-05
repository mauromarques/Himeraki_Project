//
//  ProfileViewModel.swift
//  TableViewWithMultipleCellTypes
//
//  Created by Stanislav Ostrovskiy on 4/25/17.
//  Copyright © 2017 Stanislav Ostrovskiy. All rights reserved.
//

import Foundation
import UIKit

enum NewsViewModelItemType {
    case challenge
    case featuredArtist
    case supplyReview
    case article
    case tipsAndTricks
}

protocol NewsViewModelItem {
    var type: NewsViewModelItemType { get }
    var rowCount: Int { get }
}

class NewsViewModel: NSObject {
    var items = [NewsViewModelItem]()
    
    override init() {
        super.init()
        
        items = [
            ProfileViewModelNamePictureItem(name: "lal", pictureUrl: "pictureUrl"),
            ProfileViewModelAboutItem(name: "name", pictureUrl: "pictureUrl"),
            ProfileViewModelEmailItem(name: "name", pictureUrl: "pictureUrl"),
            ProfileViewModeAttributeItem(name: "name", pictureUrl: "pictureUrl"),
            ProfileViewModeFriendsItem(name: "name", pictureUrl: "pictureUrl")
        ]
    }
}

extension NewsViewModel: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = items[indexPath.section]
        
        switch item.type {
        case .challenge:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeCell.identifier, for: indexPath) as? ChallengeCell {
                return cell
            }
        case .featuredArtist:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedArtistCell.identifier, for: indexPath) as? FeaturedArtistCell {
                return cell
            }
        case .supplyReview:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SupplyReviewCell.identifier, for: indexPath) as? SupplyReviewCell {
                return cell
            }
        case .article:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.identifier, for: indexPath) as? ArticleCell {
                return cell
            }
        case .tipsAndTricks:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TipsAndTricksCell.identifier, for: indexPath) as? TipsAndTricksCell {
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

class ProfileViewModelNamePictureItem: NewsViewModelItem {
    
    var type: NewsViewModelItemType {
        return .challenge
    }

    var rowCount: Int {
        return 1
    }
    
    var name: String
    var pictureUrl: String
    
    init(name: String, pictureUrl: String) {
        self.name = name
        self.pictureUrl = pictureUrl
    }
}

class ProfileViewModelAboutItem: NewsViewModelItem {
    
    var type: NewsViewModelItemType {
        return .featuredArtist
    }

    var rowCount: Int {
        return 1
    }

    var name: String
    var pictureUrl: String
    
    init(name: String, pictureUrl: String) {
        self.name = name
        self.pictureUrl = pictureUrl
    }
}

class ProfileViewModelEmailItem: NewsViewModelItem {
    
    var type: NewsViewModelItemType {
        return .supplyReview
    }

    var rowCount: Int {
        return 1
    }

    var name: String
    var pictureUrl: String
    
    init(name: String, pictureUrl: String) {
        self.name = name
        self.pictureUrl = pictureUrl
    }
}

class ProfileViewModeAttributeItem: NewsViewModelItem {
    
    var type: NewsViewModelItemType {
        return .tipsAndTricks
    }

    var rowCount: Int {
        return 1
    }

    var name: String
    var pictureUrl: String
    
    init(name: String, pictureUrl: String) {
        self.name = name
        self.pictureUrl = pictureUrl
    }
}

class ProfileViewModeFriendsItem: NewsViewModelItem {
    
    var type: NewsViewModelItemType {
        return .article
    }

    var rowCount: Int {
        return 1
    }

    var name: String
    var pictureUrl: String
    
    init(name: String, pictureUrl: String) {
        self.name = name
        self.pictureUrl = pictureUrl
    }
}


