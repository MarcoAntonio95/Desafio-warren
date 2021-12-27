//
//  LoginViewModel.swift
//  App
//
//  Created by Marco Antonio on 22/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class LoginViewModel {

    // MARK: Varbles & Constants
    private let coordinator: LoginFlowCoordinator
    private let disposeBag = DisposeBag()
    private let minPasswordCharacters = 6
    let emailSubject = BehaviorRelay<String?>(value: "")
    let passwordSubject = BehaviorRelay<String?>(value: "")
   
    var isValidForm: Observable<Bool> {
       return Observable.combineLatest(emailSubject, passwordSubject) {  email, password in
           guard email != nil && password != nil else {
               return false
           }
           return self.validateEmail(email: email!) && password!.count >= self.minPasswordCharacters
       }
    }
    
    // MARK: Initialization
    init(coordinator: LoginFlowCoordinator) {
        self.coordinator = coordinator
    }

    // MARK: Public functions
    func login(email:String,password:String) -> Observable<String> {
       return APIService.sharedInstance.postLoginInAPI(email: email, password: password)
    }

    func goToPortfoliosFlow(){
        self.coordinator.dismissSheet()
    }
    
    // MARK: Privated functions
    func validateEmail(email:String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
}
