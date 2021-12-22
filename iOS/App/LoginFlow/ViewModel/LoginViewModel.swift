//
//  LoginViewModel.swift
//  App
//
//  Created by Matheus Lutero on 22/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

final class LoginViewModel {

    private let coordinator: LoginFlowCoordinator
    let emailSubject = BehaviorRelay<String?>(value: "")
    let passwordSubject = BehaviorRelay<String?>(value: "")
    let disposeBag = DisposeBag()
    let minPasswordCharacters = 6
    
    init(coordinator: LoginFlowCoordinator) {
        self.coordinator = coordinator
    }

    fileprivate func validateEmail(email:String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: email)
    }
    
    var isValidForm: Observable<Bool> {
       return Observable.combineLatest(emailSubject, passwordSubject) {  email, password in
           guard email != nil && password != nil else {
               return false
           }
           return self.validateEmail(email: email!) && password!.count >= self.minPasswordCharacters
       }
    }
    
    func login(email:String,password:String) -> Observable<String> {
       return APIService.sharedInstance.postLoginInAPI(email: email, password: password)
    }
    
    func finishFlow(){
        self.coordinator.finish()
    }
}
