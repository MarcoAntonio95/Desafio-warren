//
//  Coordinator.swift
//  App
//
//  Created by Marco Antonio on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var navigationController: UINavigationController { get set }
    var type: CoordinatorType { get }
    var childCoordinators: [Coordinator] { get set }
    func start()
    func finish()
    
    init(_ navigationController: UINavigationController)
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func finishWithData(data: Any){
        finishDelegate?.coordinatorDidFinishWithData(data: data, childCoordinator: self)
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
    func coordinatorDidFinishWithData(data: Any,childCoordinator: Coordinator)
}

protocol CoordinatorTitleDelegate: AnyObject {
    func setNavigationTitle(title: String)
}

enum CoordinatorType {
    case root, initial, login, portfolios, details
}
