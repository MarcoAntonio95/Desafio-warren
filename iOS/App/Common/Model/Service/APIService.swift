//
//  APIService.swift
//  App
//
//  Created by Matheus Lutero on 22/12/21.
//  Copyright © 2021 Warren. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class APIService {
    
    static let sharedInstance = APIService()
    
    let disposeBag = DisposeBag()
    
    func postLoginInAPI(email:String,password:String) -> Observable<String> {
        return Observable.create { observer -> Disposable in
            let urlPost = "https://enigmatic-bayou-48219.herokuapp.com/api/v2/account/login"
            
            let headers: HTTPHeaders = [
                "Content-Type":"application/json"
            ]
            
            let json: [String: Any] = [
                "email" : email,
                "password" : password
            ]
            
            AF.request(urlPost, method: .post, parameters: json, encoding: JSONEncoding.default,headers: headers)
                .responseJSON { response in
                    switch response.result {
                        case .success(let value):
                        //mobile_test@warrenbrasil.com
                        //Warren123!
                        let json = value as? NSDictionary
                        
                        let error = json?["error"] as? String
                        
                        if error == nil {
                            guard let accessToken = json?["accessToken"] as? String else {
                                return
                            }
                            observer.onNext(accessToken)
                        } else {
                            guard let errorStr = error else {
                                return
                            }
                            observer.onError(NSError(domain: errorStr, code: 0, userInfo: nil))
                        }
                   
                        case .failure(let error):
                            observer.onError(NSError(domain: "Request Error: \(error)", code: error.responseCode ?? 0, userInfo: nil))
                        }
                    }
            return Disposables.create {}
        }
    }
}
