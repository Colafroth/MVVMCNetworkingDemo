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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let config = ServiceConfiguration()
        let service = Service(configuration: config!)
        ArticleOperation().execute(in: service, onSuccess: { articles in
            print(articles)
        }) { error in
            print(error)
        }

        return true
    }
}
