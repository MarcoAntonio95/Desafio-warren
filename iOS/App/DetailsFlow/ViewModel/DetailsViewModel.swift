//
//  DetailsViewModel.swift
//  App
//
//  Created by Matheus Lutero on 21/12/21.
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

    func downloadJSONImage(imageUrl: String) -> Observable<Data> {
        return APIService.sharedInstance.downloadJSONImage(imageUrl: imageUrl)
    }
    
    func finishFlow(){
        self.coordinator.finish()
    }
}
