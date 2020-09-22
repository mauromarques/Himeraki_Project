//
//  NotificationManager.swift
//  HimerakiProject
//
//  Created by Vinicius Moreira Leal on 09/02/2020.
//  Copyright © 2020 Mauro Marques. All rights reserved.
//

import CloudKit
import Foundation

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

        database.fetchAllSubscriptions { [weak self] subscriptions, error in
            guard let self = self else { return }

            if error == nil {
                debugPrint("🔴🔴\("There's no error")🟢🟢")
                if let subscriptions = subscriptions {
                    debugPrint("🔴🔴 Subscriptions count \(subscriptions.count)🟢🟢")
                    if subscriptions.isEmpty {
                        debugPrint("🔴🔴 Creating Subscriptions 🟢🟢")
                        self.prepareNotification(ids: [1, 2, 3, 4], in: database)
                        self.prepareNotification(ids: [0], in: database)
                    }
                }
            } else {
                debugPrint("🔴🔴 \(error!.localizedDescription) 🟢🟢")
            }
        }
    }

    private func prepareNotification(ids: [Int], in database: CKDatabase) {
        // Retrieve record with item_id which is inside the wantedItemIDs array
        let predicate = NSPredicate(format: "id IN %@", ids)

        let subscription = CKQuerySubscription(recordType: "News", predicate: predicate, options: [.firesOnRecordCreation])

        let notification = CKSubscription.NotificationInfo()
        let challengeBody = "There's a new challenge for you!"
        let articleBody = "There's a new article for you."
        notification.alertBody = ids.count == 1 ? challengeBody : articleBody
        notification.soundName = "default"

        subscription.notificationInfo = notification

        database.save(subscription) { _, error in
            debugPrint("🔴🔴 Subscription created 🟢🟢")
            if let error = error {
                debugPrint("🔴🔴 \(error.localizedDescription) 🟢🟢")
            }
        }
    }
}
