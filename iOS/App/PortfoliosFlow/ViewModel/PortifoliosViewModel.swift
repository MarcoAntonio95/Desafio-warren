//
//  InitialViewModel.swift
//  App
//
//  Created by Matheus Lutero on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

final class PortfoliosViewModel {

    private let coordinator: PortfoliosFlowCoordinator
    
    init(coordinator: PortfoliosFlowCoordinator) {
        self.coordinator = coordinator
    }

    func startDetailsFlow(){
        self.coordinator.finish()
    }
}
