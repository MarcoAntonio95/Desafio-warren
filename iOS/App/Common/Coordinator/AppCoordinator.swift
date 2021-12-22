//
//  AppCoordinator.swift
//  App
//
//  Created by Matheus Lutero on 20/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func showInitialFlow()
}

class AppCoordinator: AppCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .root }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }

    func start() {
        showInitialFlow()
    }
        
    func showInitialFlow() {
        let initialFlowCoordinator = InitialFlowCoordinator.init(navigationController)
        initialFlowCoordinator.finishDelegate = self
        initialFlowCoordinator.start()
        childCoordinators.append(initialFlowCoordinator)
    }
    
    func startPortfoliosFlow() {
        let portfoliosFlowCoordinator = PortfoliosFlowCoordinator.init(navigationController)
        portfoliosFlowCoordinator.finishDelegate = self
        portfoliosFlowCoordinator.start()
        childCoordinators.append(portfoliosFlowCoordinator)
    }
    
    func startDetailsFlow() {
        let detailsFlowCoordinator = DetailsFlowCoordinator.init(navigationController)
        detailsFlowCoordinator.finishDelegate = self
        detailsFlowCoordinator.start()
        childCoordinators.append(detailsFlowCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })

        switch childCoordinator.type {
        case .root:
            print("📱 root")
        case .initial:
            print("📱 initial")
            self.startPortfoliosFlow()
        case .portfolios:
            print("📱 portfolios")
            self.startDetailsFlow()
        case .details:
            print("📱 detail")
        }
    }
}
