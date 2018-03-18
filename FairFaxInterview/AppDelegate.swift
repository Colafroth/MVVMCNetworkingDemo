//
//  AppDelegate.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 15/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        if let window = window {
            self.appCoordinator = AppCoordinator(window: window)
            self.appCoordinator.start()
        }
        return true
    }
}
