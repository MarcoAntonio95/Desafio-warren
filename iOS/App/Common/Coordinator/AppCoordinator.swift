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
        
    internal func showInitialFlow() {
        let initialFlowCoordinator = InitialFlowCoordinator.init(navigationController)
        initialFlowCoordinator.finishDelegate = self
        childCoordinators.append(initialFlowCoordinator)
        initialFlowCoordinator.start()
    }
    
    internal func startLoginFlow(){
        let loginFlowCoordinator = LoginFlowCoordinator.init(navigationController)
        loginFlowCoordinator.finishDelegate = self
        childCoordinators.append(loginFlowCoordinator)
        loginFlowCoordinator.start()
    }
    
    internal func startPortfoliosFlow() {
        let portfoliosFlowCoordinator = PortfoliosFlowCoordinator.init(navigationController)
        portfoliosFlowCoordinator.finishDelegate = self
        portfoliosFlowCoordinator.start()
        childCoordinators.append(portfoliosFlowCoordinator)
       
    }
    
    internal func startDetailsFlow() {
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
            self.startLoginFlow()
        case .login:
            print("📱 login")
            self.startPortfoliosFlow()
        case .portfolios:
            print("📱 portfolios")
            self.startDetailsFlow()
        case .details:
            print("📱 detail")
        }
    }
}
