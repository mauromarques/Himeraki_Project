//
//  NotificationAuthorization.swift
//  HimerakiProject
//
//  Created by Vinicius Moreira Leal on 09/02/2020.
//  Copyright © 2020 Mauro Marques. All rights reserved.
//

import UIKit

class NotificationAuthorization {
    
    func makeRequest() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("\(error.localizedDescription)")
            } else {
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
            }
        }
    }
}
