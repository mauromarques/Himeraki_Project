//
//  NewsViewModel.swift
//  HimerakiProject
//
//  Created by Vinicius Leal on 02/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

enum NewsViewModelItemType: String, CustomStringConvertible {
    
    case challenge = "Challenge"
    case featuredArtist = "FeaturedArtist"
    case supplyReview = "SupplyReview"
    case article = "Article"
    case tipsAndTricks = "TipsAndTricks"
    
    var description: String {
        return self.rawValue
    }
}

protocol NewsViewModelItem {
    var type: NewsViewModelItemType { get }
    var rowCount: Int { get }
    var new: News { get }
}

class NewsViewModel: NSObject {
    
    var items = [NewsViewModelItem]()
    
    var news = [News]()  {
        didSet {
            self.notificationQueue.addOperation {
                self.populateNewsCells()
            }
        }
    }
    
    private let database = CKContainer.default().publicCloudDatabase
    
    var onChange : (() -> Void)?
    var onError : ((Error) -> Void)?
    var notificationQueue = OperationQueue.main
    
    var records = [CKRecord]()
    var insertedObjects = [News]()
    var deletedObjectIds = Set<CKRecord.ID>()
    
    override init() {
        super.init()
        
    }
    
    func delete(at index : Int) {
        
        let recordID = self.news[index].record.recordID
        database.delete(withRecordID: recordID) { _, error in
            guard error == nil else {
                self.handle(error: error!)
                return
            }
        }
        
        deletedObjectIds.insert(recordID)
        updateNews()
    }
    
    fileprivate func handle(error: Error) {
        self.notificationQueue.addOperation {
            self.onError?(error)
        }
    }
    
    fileprivate func updateNews() {
        
        var knownIds = Set(records.map { $0.recordID })
        
        // remove objects from our local list once we see them returned from the cloudkit storage
        self.insertedObjects.removeAll { new in
            knownIds.contains(new.record.recordID)
        }
        knownIds.formUnion(self.insertedObjects.map { $0.record.recordID })
        
        // remove objects from our local list once we see them not being returned from storage anymore
        self.deletedObjectIds.formIntersection(knownIds)
        
        var news = records.map { News(record: $0) }
 
        news.append(contentsOf: self.insertedObjects)
        
        news.removeAll { new in
            deletedObjectIds.contains(new.record.recordID)
        }
        
        self.news = news

    }
    
    @objc func refresh() {
        
        let query = CKQuery(recordType: News.recordType, predicate: NSPredicate(value: true))
        
        database.perform(query, inZoneWith: nil) { records, error in
            guard let records = records, error == nil else {
                self.handle(error: error!)
                return
            }
            
            self.records = records
            
            self.updateNews()
        }
        
    }
    
    func populateNewsCells() {

        items.removeAll()
        
        news.forEach({
        
            guard let category = $0.type else { return }
            
            switch category {
            case "Challenge":
                items.append(NewsViewModelChallenge(new: $0))
            case "FeaturedArtist":
                items.append(NewsViewModelArtist(new: $0))
            case "SupplyReview":
                items.append(NewsViewModelSupply(new: $0))
            case "TipsAndTricks":
                items.append(NewsViewModelTips(new: $0))
            case "Article":
                items.append(NewsViewModelArticle(new: $0))
            default:
                break
            }
        })
        
        items.sort {
            $0.new.order < $1.new.order
        }
        
        self.onChange?()
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
        case .tipsAndTricks:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TipsAndTricksCell.identifier, for: indexPath) as? TipsAndTricksCell {
                
                cell.new = item.new
                return cell
            }
        case .challenge:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChallengeCell.identifier, for: indexPath) as? ChallengeCell {
                
                cell.new = item.new
                return cell
            }
        case .featuredArtist:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeaturedArtistCell.identifier, for: indexPath) as? FeaturedArtistCell {
                
                cell.new = item.new
                return cell
            }
        case .supplyReview:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SupplyReviewCell.identifier, for: indexPath) as? SupplyReviewCell {
                
                cell.new = item.new
                return cell
            }
        case .article:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArticleCell.identifier, for: indexPath) as? ArticleCell {
                
                cell.new = item.new
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

class NewsViewModelChallenge: NewsViewModelItem {
    
    var type: NewsViewModelItemType {
        return .challenge
    }

    var rowCount: Int {
        return 1
    }

    var new: News
    
    init(new: News) {
        
        self.new = new
    }
}

class NewsViewModelArticle: NewsViewModelItem {
    
    var type: NewsViewModelItemType {
        return .featuredArtist
    }

    var rowCount: Int {
        return 1
    }
    
    var new: News
    
    init(new: News) {
        
        self.new = new
    }
}

class NewsViewModelSupply: NewsViewModelItem {

    var type: NewsViewModelItemType {
        return .supplyReview
    }

    var rowCount: Int {
        return 1
    }

    var new: News
    
    init(new: News) {
        
        self.new = new
    }
}

class NewsViewModelTips: NewsViewModelItem {

    var type: NewsViewModelItemType {
        return .tipsAndTricks
    }

    var rowCount: Int {
        return 1
    }

    var new: News
    
    init(new: News) {
        
        self.new = new
    }
}

class NewsViewModelArtist: NewsViewModelItem {
    
    var type: NewsViewModelItemType {
        return .article
    }

    var rowCount: Int {
        return 1
    }

    var new: News
    
    init(new: News) {
        
        self.new = new
    }
}


