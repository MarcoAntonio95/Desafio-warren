//
//  DetailsViewModel.swift
//  App
//
//  Created by Matheus Lutero on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

final class DetailsViewModel {

    private let coordinator: DetailsFlowCoordinator
    
    init(coordinator: DetailsFlowCoordinator) {
        self.coordinator = coordinator
    }

    func finishFlow(){
        self.coordinator.finish()
    }
}
