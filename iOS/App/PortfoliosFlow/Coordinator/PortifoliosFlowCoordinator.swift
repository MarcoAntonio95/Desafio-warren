//
//  PortfoliosFlowCoordinator.swift
//  App
//
//  Created by Marco Antonio on 20/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit

protocol PortfoliosFlowCoordinatorProtocol: Coordinator {
    func startPortfoliosViewController()
}

class PortfoliosFlowCoordinator: Coordinator, PortfoliosFlowCoordinatorProtocol {
    
    // MARK: Varbles & Constants
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .portfolios }
    
    // MARK: Initialization
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Public functions
    func start() {
        self.startPortfoliosViewController()
    }
    
    // MARK: Internal functions
    internal func startPortfoliosViewController() {
        let portfoliosViewModel = PortfoliosViewModel(coordinator: self)
        let portfoliosVC: PortfoliosViewController = .init(viewModel: portfoliosViewModel)
        navigationController.pushViewController(portfoliosVC, animated: true)
    }
    
    // MARK: Deinitialization
    deinit {
        print("PortfoliosFlowCoordinator deinit")
    }
}
