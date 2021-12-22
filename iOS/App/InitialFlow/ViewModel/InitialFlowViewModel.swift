//
//  InitialFlowViewModel.swift
//  App
//
//  Created by Matheus Lutero on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

final class InitialFlowViewModel {

    private let coordinator: InitialFlowCoordinator
    
    init(coordinator: InitialFlowCoordinator) {
        self.coordinator = coordinator
    }

    func startPortfoliosFlow(){
        self.coordinator.finish()
    }
}
