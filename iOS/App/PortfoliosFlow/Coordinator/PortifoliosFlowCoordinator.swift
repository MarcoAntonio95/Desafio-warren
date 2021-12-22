//
//  InitialFlowCoordinator.swift
//  App
//
//  Created by Matheus Lutero on 20/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit

protocol PortfoliosFlowCoordinatorProtocol: Coordinator {
    func startPortfoliosViewController()
}

class PortfoliosFlowCoordinator: Coordinator, PortfoliosFlowCoordinatorProtocol {
     var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .portfolios }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        startPortfoliosViewController()
    }
    
    deinit {
        print("PortfoliosFlowCoordinator deinit")
    }
    
    func startPortfoliosViewController() {
        let portfoliosViewModel = PortfoliosViewModel(coordinator: self)
        let portfoliosVC: PortfoliosViewController = .init(viewModel: portfoliosViewModel)
        navigationController.pushViewController(portfoliosVC, animated: true)
    }
}
