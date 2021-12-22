//
//  LoginViewModel.swift
//  App
//
//  Created by Matheus Lutero on 22/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation

final class LoginViewModel {

    private let coordinator: LoginFlowCoordinator
    
    init(coordinator: LoginFlowCoordinator) {
        self.coordinator = coordinator
    }

    func finishFlow(){
        self.coordinator.finish()
    }
}
