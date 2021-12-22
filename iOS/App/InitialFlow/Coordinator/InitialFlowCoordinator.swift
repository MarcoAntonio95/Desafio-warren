//
//  InitialFlowCoordinator.swift
//  App
//
//  Created by Matheus Lutero on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit

protocol InitialFlowCoordinatorProtocol: Coordinator {
    func startInitialFlowViewController()
}

class InitialFlowCoordinator: Coordinator, InitialFlowCoordinatorProtocol {
    var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .initial }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        startInitialFlowViewController()
    }
    
    deinit {
        print("InitialFlowCoordinator deinit")
    }
    
    func startInitialFlowViewController() {
        let initialFlowViewModel = InitialFlowViewModel(coordinator: self)
        let initialFlowVC: InitialFlowViewController = .init(viewModel: initialFlowViewModel)
        navigationController.pushViewController(initialFlowVC, animated: true)
    }
}
