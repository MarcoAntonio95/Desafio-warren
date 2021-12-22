//
//  InitialFlowCoordinator.swift
//  App
//
//  Created by Matheus Lutero on 20/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit

protocol InitialFlowCoordinatorProtocol: Coordinator {
    func startInitialViewController()
}

class InitialFlowCoordinator: InitialFlowCoordinatorProtocol {
     var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .initial }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        startInitialViewController()
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    func startInitialViewController() {
        let initialViewModel = InitialViewModel(coordinator: self)
        let initialVC: InitialViewController = .init(viewModel: initialViewModel)
        navigationController.pushViewController(initialVC, animated: true)
    }
}
