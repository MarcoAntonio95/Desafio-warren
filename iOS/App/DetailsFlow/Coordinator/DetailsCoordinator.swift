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
    func startDetailsViewController(_ currentPortfolio: Portfolio)
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
        startDetailsViewController(Portfolio())
    }
    
    func startWithData(currentPortfolio: Portfolio){
        self.startDetailsViewController(currentPortfolio)
    }
    
    deinit {
        print("DetailsFlowCoordinator deinit")
    }
    
    internal func startDetailsViewController(_ detailPortfolio:Portfolio) {
        let detailsViewModel = DetailsViewModel(coordinator: self)
        let detailsVC: DetailsViewController = .init(viewModel: detailsViewModel)
        if !detailPortfolio.id.isEmpty {
            detailsVC.currentPortfolio = detailPortfolio
        }
        navigationController.pushViewController(detailsVC, animated: true)
    }
}
