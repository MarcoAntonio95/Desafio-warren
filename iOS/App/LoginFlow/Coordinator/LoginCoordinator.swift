//
//  LoginCoordinator.swift
//  App
//
//  Created by Marco Antonio on 22/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit

protocol LoginFlowCoordinatorProtocol: Coordinator {
    func startLoginViewController()
}

class  LoginFlowCoordinator: Coordinator, LoginFlowCoordinatorProtocol {
    
    // MARK: Varbles & Constants
    var finishDelegate: CoordinatorFinishDelegate?
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    var type: CoordinatorType { .login }
    
    // MARK: Initialization
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    // MARK: Public functions
    func start() {
        self.startLoginViewController()
    }
    
    func dismissSheet(){
        self.navigationController.dismiss(animated: true)
        self.finish()
    }
    
    // MARK: Internal functions
    internal func startLoginViewController() {
        let loginViewModel = LoginViewModel(coordinator: self)
        let loginVC: LoginViewController = .init(viewModel: loginViewModel)
        if #available(iOS 15.0, *) {
            if let sheet = loginVC.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
                sheet.largestUndimmedDetentIdentifier = .large
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                sheet.prefersEdgeAttachedInCompactHeight = true
                sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
            }
        }
        self.navigationController.present(loginVC, animated: true, completion: nil)
    }
    
    // MARK: Deinitialization
    deinit {
        print("DetailsFlowCoordinator deinit")
    }
}
