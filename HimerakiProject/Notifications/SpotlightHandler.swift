//
//  Spotlight.swift
//  HimerakiProject
//
//  Created by Vinicius Moreira Leal on 07/04/2020.
//  Copyright © 2020 Mauro Marques. All rights reserved.
//

import Foundation

struct SpotlightHandler {
    
    static let activityType = "com.hira.activity"
    static let drawingIdeasID = "drawing-ideas"
    
    static func setActivity() -> NSUserActivity {
        let userActivity = NSUserActivity(activityType: SpotlightHandler.activityType)
        userActivity.title = "Drawing ideas"
        userActivity.persistentIdentifier = SpotlightHandler.drawingIdeasID
        userActivity.isEligibleForSearch = true // add this item to the Spotlight index
        userActivity.isEligibleForPublicIndexing = true // add this item to the public index
        
        return userActivity
    }
}
