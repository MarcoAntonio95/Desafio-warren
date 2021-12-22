//
//  DetailsCoordinator.swift
//  App
//
//  Created by Matheus Lutero on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsFlowCoordinatorProtocol: Coordinator {
    func startDetailsViewController()
}

class  DetailsFlowCoordinator: Coordinator, DetailsFlowCoordinatorProtocol {
     var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .details }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        startDetailsViewController()
    }
    
    deinit {
        print("DetailsFlowCoordinator deinit")
    }
    
    func startDetailsViewController() {
        let detailsViewModel = DetailsViewModel(coordinator: self)
        let detailsVC: DetailsViewController = .init(viewModel: detailsViewModel)
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
