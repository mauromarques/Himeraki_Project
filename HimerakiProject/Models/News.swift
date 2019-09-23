//
//  News.swift
//  TableViewWithMultipleCellTypes
//
//  Created by Stanislav Ostrovskiy on 4/25/17.
//  Copyright © 2017 Stanislav Ostrovskiy. All rights reserved.
//

import Foundation
import CloudKit

struct News {
    
    static let recordType = "News"
    
    fileprivate static let type = "type"
    fileprivate static let topTitle = "topTitle"
    fileprivate static let pictureUrl = "pictureUrl"
    fileprivate static let title = "title"
    fileprivate static let subtitle = "subtitle"
    fileprivate static let instaLink = "instaLink"
    fileprivate static let order = "id"
    fileprivate static let articleText = "articleText"
    
    var record: CKRecord
    
    init(record : CKRecord) {
        self.record = record
        
    }
    
    init() {
        self.record = CKRecord(recordType: News.recordType)
        
    }
    
    var order: Int {
        get {
            return self.record.value(forKey: News.order) as! Int
        }
    }
    
    var type: String? {
        get {
            return self.record.value(forKey: News.type) as? String
        }
    }
    
    var topTitle: String? {
        get {
            return self.record.value(forKey: News.topTitle) as? String
        }
    }
    
    var pictureUrl: String? {
        get {
            return self.record.value(forKey: News.pictureUrl) as? String
        }
    }
    
    var title: String? {
        get {
            return self.record.value(forKey: News.title) as? String
        }
    }
    
    var subtitle: String? {
        get {
            return self.record.value(forKey: News.subtitle) as? String
        }
    }
    
    var instaLink: String? {
        get {
            return self.record.value(forKey: News.instaLink) as? String
        }
    }
    
    var articleText: String? {
        get {
            return self.record.value(forKey: News.articleText) as? String
        }
    }
    
}

