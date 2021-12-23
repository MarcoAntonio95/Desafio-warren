//
//  InitialViewModel.swift
//  App
//
//  Created by Matheus Lutero on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PortfoliosViewModel {

    private let coordinator: PortfoliosFlowCoordinator
    
    init(coordinator: PortfoliosFlowCoordinator) {
        self.coordinator = coordinator
    }

    func startDetailsFlow(currentPortfolio: Any){
        self.coordinator.finishWithData(data: currentPortfolio)
    }
    
    func getAllPortfolios() -> Observable<[Portfolio]> {
        return APIService.sharedInstance.fetchAllPortfolios()
    }
    
    func downloadJSONImage(imageUrl: String) -> Observable<Data> {
        return APIService.sharedInstance.downloadJSONImage(imageUrl: imageUrl)
    }
}
