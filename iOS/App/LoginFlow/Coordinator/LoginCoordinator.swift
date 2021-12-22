//
//  LoginCoordinator.swift
//  App
//
//  Created by Matheus Lutero on 22/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit

protocol LoginFlowCoordinatorProtocol: Coordinator {
    func startLoginViewController()
}

class  LoginFlowCoordinator: Coordinator, LoginFlowCoordinatorProtocol {
     var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .login }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        startLoginViewController()
    }
    
    deinit {
        print("DetailsFlowCoordinator deinit")
    }
    
    func startLoginViewController() {
        let loginViewModel = LoginViewModel(coordinator: self)
        let loginVC: LoginViewController = .init(viewModel: loginViewModel)
        navigationController.pushViewController(loginVC, animated: true)
    }
}
