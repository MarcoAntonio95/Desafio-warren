//
//  InitialFlowCoordinator.swift
//  App
//
//  Created by Marco Antonio on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit

protocol InitialFlowCoordinatorProtocol: Coordinator {
    func startInitialFlowViewController()
}

class InitialFlowCoordinator: Coordinator, InitialFlowCoordinatorProtocol {
    
    // MARK: Varbles & Constants
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .initial }
        
    // MARK: Initialization
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    // MARK: Public functions
    func start() {
        startInitialFlowViewController()
    }
    
    // MARK: Internal functions
    internal func startInitialFlowViewController() {
        let initialFlowViewModel = InitialFlowViewModel(coordinator: self)
        let initialFlowVC: InitialFlowViewController = .init(viewModel: initialFlowViewModel)
        navigationController.pushViewController(initialFlowVC, animated: true)
    }
    
    // MARK: Deinitialization
    deinit {
        print("InitialFlowCoordinator deinit")
    }
}
