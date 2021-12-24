//
//  InitialFlowViewModel.swift
//  App
//
//  Created by Marco Antonio on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

final class InitialFlowViewModel {

    // MARK: Varbles & Constants
    private let coordinator: InitialFlowCoordinator
    
    // MARK: Initialization
    init(coordinator: InitialFlowCoordinator) {
        self.coordinator = coordinator
    }

    // MARK: Public functions
    func startPortfoliosFlow(){
        self.coordinator.finish()
    }
}
