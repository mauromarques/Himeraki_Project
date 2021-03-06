//
//  News.swift
//  HimerakiProject
//
//  Created by Vinicius Leal on 02/09/19.
//  Copyright © 2019 Vinicius Leal. All rights reserved.
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
    fileprivate static let artistName = "artistName"
    fileprivate static let photoCredits = "photoCredits"
    fileprivate static let publisher = "publisher"
    
    var record: CKRecord
    
    init(record : CKRecord) {
        self.record = record
        
    }
    
    init() {
        self.record = CKRecord(recordType: News.recordType)
        
    }
    
    var order: String {
        get {
            return self.record.value(forKey: News.order) as? String ?? "0"
        }
        set {
            self.record.setValue(newValue, forKey: News.order)
        }
    }
    
    var type: String? {
        get {
            return self.record.value(forKey: News.type) as? String
        }
        set {
            self.record.setValue(newValue, forKey: News.type)
        }
    }
    
    var topTitle: String? {
        get {
            return self.record.value(forKey: News.topTitle) as? String
        }
        set {
            self.record.setValue(newValue, forKey: News.topTitle)
        }
    }
    
    var pictureUrl: String? {
        get {
            return self.record.value(forKey: News.pictureUrl) as? String
        }
        set {
            self.record.setValue(newValue, forKey: News.pictureUrl)
        }
    }
    
    var title: String? {
        get {
            return self.record.value(forKey: News.title) as? String
        }
        set {
            self.record.setValue(newValue, forKey: News.title)
        }
    }
    
    var subtitle: String? {
        get {
            return self.record.value(forKey: News.subtitle) as? String
        }
        set {
            self.record.setValue(newValue, forKey: News.subtitle)
        }
    }
    
    var instaLink: String? {
        get {
            return self.record.value(forKey: News.instaLink) as? String
        }
        set {
            self.record.setValue(newValue, forKey: News.instaLink)
        }
    }
    
    var artistName: String? {
        get {
            return self.record.value(forKey: News.artistName) as? String
        }
        set {
            self.record.setValue(newValue, forKey: News.artistName)
        }
    }
    
    var articleText: String? {
        get {
            return self.record.value(forKey: News.articleText) as? String
        }
        set {
            self.record.setValue(newValue, forKey: News.articleText)
        }
    }
    
    var photoCredits: String? {
        get {
            return self.record.value(forKey: News.photoCredits) as? String
        }
        set {
            self.record.setValue(newValue, forKey: News.photoCredits)
        }
    }
    
    var publisher: String? {
        get {
            return self.record.value(forKey: News.publisher) as? String
        }
        set {
            self.record.setValue(newValue, forKey: News.publisher)
        }
    }
    
}

