//
//  LoginFlowTests.swift
//  AppTests
//
//  Created by Marco Antonio on 26/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import Alamofire
import Foundation

@testable import Warren

class LoginFlowTests: XCTestCase {

    private let disposeBag = DisposeBag()
    
    func testFieldsValidation(){
        let loginCoordinator = LoginFlowCoordinator(UINavigationController())
        let viewModel = LoginViewModel(coordinator: loginCoordinator)
        
        var email = viewModel.emailSubject.value
        
        email?.append("mobile_test@warrenbrasil.com")
        let isEmailValid = viewModel.validateEmail(email: email ?? "")
        
        XCTAssert(isEmailValid, "Email filled is not valid")
        
        var password = viewModel.passwordSubject.value
        password?.append("Warren123!")
        
        let isPasswordValid = password!.count >= 6
        
        XCTAssert(isPasswordValid, "Email filled is not valid")
    }
    
    func testLoginPostService(){
        let urlPost = "https://enigmatic-bayou-48219.herokuapp.com/api/v2/account/login"
        
        let headers: HTTPHeaders = [
            "Content-Type":"application/json"
        ]
        
        let json: [String: Any] = [
            "email" : "mobile_test@warrenbrasil.com",
            "password" : "Warren123!"
        ]
        
        let expectation = XCTestExpectation(description: "Test post in API")
        
        AF.request(urlPost, method: .post, parameters: json, encoding: JSONEncoding.default,headers: headers)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    XCTAssertNotNil(value,"Error in Post in API")
                    break
                case .failure(_):
                    XCTAssert(false,"Error in connection with API")
                }
                expectation.fulfill()
            }
        
        wait(for: [expectation], timeout: 30.0)
    }
    
}
