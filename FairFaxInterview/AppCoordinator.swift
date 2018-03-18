//
//  AppCoordinator.swift
//  FairFaxInterview
//
//  Created by AnTeng Lin on 18/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator: Coordinatable {
    // MARK: - Properties
    var childCoordinators = [Coordinatable]()
    var window: UIWindow

    // MARK: - Inits
    init(window: UIWindow) {
        self.window = window
    }

    // MARK: - Public Functions
    func start() {
        let coordinator = ArticleCollectionCoordinator()
        coordinator.start()
        addChildCoordinator(coordinator)
        self.window.rootViewController = coordinator.rootViewController
        self.window.makeKeyAndVisible()
    }
}
