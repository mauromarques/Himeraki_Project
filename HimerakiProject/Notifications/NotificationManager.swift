//
//  NotificationManager.swift
//  HimerakiProject
//
//  Created by Vinicius Moreira Leal on 09/02/2020.
//  Copyright © 2020 Mauro Marques. All rights reserved.
//

import Foundation
import CloudKit

public protocol SubscriptionFetcher {
    func fetchAllSubscriptions()
}

public class NotificationManager: SubscriptionFetcher {
    
    public enum Error: Swift.Error {
        case connectivity
        case unableToProceed
    }
    
    public init() {}
    
    public func fetchAllSubscriptions() {
        
        let database = CKContainer.default().publicCloudDatabase
        
        database.fetchAllSubscriptions { subscriptions, error in
            
            if error == nil {
                if let subscriptions = subscriptions {
                    if subscriptions.isEmpty {
                        let wantedItemIDs = [0, 1, 2, 3, 4]
                        
                        // Retrieve record with item_id which is inside the wantedItemIDs array
                        let predicate = NSPredicate(format: "id IN %@", wantedItemIDs)
                        
                        let subscription = CKQuerySubscription(recordType: "News", predicate: predicate, options: [.firesOnRecordCreation])
                        
                        let notification = CKSubscription.NotificationInfo()
                        notification.alertBody = "There's a new article in the collection."
                        notification.soundName = "default"
                        
                        subscription.notificationInfo = notification
                        print("cu cagado")
                        
                        database.save(subscription) { result, error in
                            if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                }
            } else {
                print(error!.localizedDescription)
            }
        }
    }
}
