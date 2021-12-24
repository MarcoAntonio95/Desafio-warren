//
//  DetailsCoordinator.swift
//  App
//
//  Created by Marco Antonio on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import UIKit

protocol DetailsFlowCoordinatorProtocol: Coordinator {
    func startDetailsViewController(_ currentPortfolio: Portfolio, _ fromCordinator: Coordinator)
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
    }
    
    func startWithData(currentPortfolio: Portfolio, fromCordinator: Coordinator){
        self.startDetailsViewController(currentPortfolio,fromCordinator)
    }
    
    deinit {
        print("DetailsFlowCoordinator deinit")
    }
    
    internal func startDetailsViewController(_ detailPortfolio:Portfolio,_ fromCordinator: Coordinator) {
        let detailsViewModel = DetailsViewModel(coordinator: self)
        let detailsVC: DetailsViewController = .init(viewModel: detailsViewModel)
        if !detailPortfolio.id.isEmpty {
            detailsVC.currentPortfolio = detailPortfolio
        }
        fromCordinator.navigationController.pushViewController(detailsVC, animated: true)
    }
}
