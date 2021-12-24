//
//  DetailsViewModel.swift
//  App
//
//  Created by Marco Antonio on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class DetailsViewModel {

    private let coordinator: DetailsFlowCoordinator
    
    init(coordinator: DetailsFlowCoordinator) {
        self.coordinator = coordinator
    }

    func downloadPortfolioImage(imageUrl: String) -> Observable<Data> {
        return APIService.sharedInstance.downloadImageFromJSON(imageUrl: imageUrl)
    }
    
    func returnToPortfolios(){
        self.coordinator.navigationController.popViewController(animated: true)
    }
}
