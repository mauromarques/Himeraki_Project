//
//  AppDelegate.swift
//  HimerakiProject
//
//  Created by Mauro Marques on 29/08/2019.
//  Copyright © 2019 Mauro Marques. All rights reserved.
//
// app id: ca-app-pub-3664459705745471~4658810445
// app id: ca-app-pub-3664459705745471~4658810445
// ad unit newsHome id: ca-app-pub-3664459705745471/2579442019
// ad unit favorites: ca-app-pub-3664459705745471/5335830810

import CoreData
import GoogleMobileAds
import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let nav1 = UINavigationController()
        nav1.isNavigationBarHidden = true
        nav1.viewControllers = [openingViewController()]
        self.window!.rootViewController = nav1
        self.window?.makeKeyAndVisible()

        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")
        if launchedBefore {
            print("Not first launch.")
            let placeData = UserDefaults.standard.data(forKey: "favorites")
            favorites = try! JSONDecoder().decode([Favorite].self, from: placeData!)
        } else {
            print("First launch")
            UserDefaults.standard.set(true, forKey: "launchedBefore")
            let favoritesData = try! JSONEncoder().encode(favorites)
            UserDefaults.standard.set(favoritesData, forKey: "favorites")
            let placeData = UserDefaults.standard.data(forKey: "favorites")
            favorites = try! JSONDecoder().decode([Favorite].self, from: placeData!)
        }

        GADMobileAds.sharedInstance().start(completionHandler: nil)

        print(favorites)

        categoriesToGetPrompt.removeAll()

        self.initiateGridFiles(named: "Nature-Grid view", "Character design-Grid view", "Composition-Grid view", "Day-to-day-Grid view", "Fantasy-Grid view")

        UNUserNotificationCenter.current().delegate = self

        self.window?.backgroundColor = .white
        return true
    }

    private func initiateGridFiles(named: String...) {
        for name in named {
            if let path = Bundle.main.path(forResource: name, ofType: ".csv") {
                readCsvFromFile(path: path)
            } else {
                fatalError("Could not load CSV file named: \(name)")
            }
        }
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        self.selectTabBar(item: 0)
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound, .badge])
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        let favoritesData = try! JSONEncoder().encode(favorites)
        UserDefaults.standard.set(favoritesData, forKey: "favorites")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        let placeData = UserDefaults.standard.data(forKey: "favorites")
        favorites = try! JSONDecoder().decode([Favorite].self, from: placeData!)
        print(favorites)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        let placeData = UserDefaults.standard.data(forKey: "favorites")
        favorites = try! JSONDecoder().decode([Favorite].self, from: placeData!)
        print(favorites)
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == SpotlightHandler.activityType {
            self.selectTabBar(item: 1)

            return true
        }
        return false
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    private func selectTabBar(item: Int) {
        if let tabBarController = window?.rootViewController as? UITabBarController {
            tabBarController.selectedIndex = item
        }
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "HimerakiProject")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
