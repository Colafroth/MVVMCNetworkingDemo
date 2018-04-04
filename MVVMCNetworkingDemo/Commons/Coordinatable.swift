//
//  Coordinator.swift
//  MVVMCNetworkingDemo
//
//  Created by AnTeng Lin on 18/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import Foundation

protocol Coordinatable: class {
    var childCoordinators: [Coordinatable] { get set }
    func start()
}

extension Coordinatable {
    func addChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators.append(coordinator)
    }

    func removeChildCoordinator(_ coordinator: Coordinatable) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
    }
}
