//
//  PortfoliosViewModel.swift
//  App
//
//  Created by Marco Antonio on 21/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class PortfoliosViewModel {
    
    // MARK: Varbles & Constants
    private let coordinator: PortfoliosFlowCoordinator
    
    // MARK: Initialization
    init(coordinator: PortfoliosFlowCoordinator) {
        self.coordinator = coordinator
    }

    // MARK: Public functions
    func returnToInitialFlow(){
        self.coordinator.finish()
    }
    
    func startDetailsFlow(currentPortfolio: Any){
        self.coordinator.finishWithData(data: currentPortfolio)
    }
    
    func getAllPortfolios() -> Observable<[Portfolio]> {
        return APIService.sharedInstance.fetchAllPortfolios()
    }
    
    func downloadJSONImage(imageUrl: String) -> Observable<Data> {
        return APIService.sharedInstance.downloadImageFromJSON(imageUrl: imageUrl)
    }
}
