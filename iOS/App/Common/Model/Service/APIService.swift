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
    
    public static let sharedInstance = APIService()
    private let disposeBag = DisposeBag()
    let portfoliosUrl = "https://enigmatic-bayou-48219.herokuapp.com/api/v2/portfolios/mine"
    private var accessToken = ""
    
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
                        
                        let json = value as? NSDictionary
                        
                        let error = json?["error"] as? String
                        
                        if error == nil {
                            guard let accessToken = json?["accessToken"] as? String else {
                                return
                            }
                            self.accessToken = accessToken
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
    
    func fetchAllPortfolios() -> Observable<[Portfolio]> {
        return Observable.create { observer -> Disposable in
            let headers: HTTPHeaders = [
                "Content-Type":"application/json",
                "access-token":self.accessToken,
            ]
            AF.request(self.portfoliosUrl, method: .get,headers: headers).validate().responseJSON { response in
                    switch response.result {
                    case .success(let value):
                        let json = value as? NSDictionary
                        
                        let portfolios = json?["portfolios"] as? NSArray
                        var portfoliosList = [Portfolio]()
                        
                        _ = portfolios?.map { item in
                            let portfolio = item as? NSDictionary
                            let id = portfolio?["_id"] as? String ?? ""
                            let name = portfolio?["name"] as? String ?? ""
                            let goalDate = portfolio?["goalDate"] as? String ?? ""
                            let goalAmount = portfolio?["goalAmount"] as? Double ?? 0.0
                            let totalBalance = portfolio?["totalBalance"] as? Double ?? 0.0
                            
                            let background = portfolio?["background"] as? NSDictionary
                            
                            let thumb = background?["thumb"] as? String ?? ""
                            let small = background?["small"] as? String ?? ""
                            let full = background?["full"] as? String ?? ""
                            let regular = background?["regular"] as? String ?? ""
                            let raw = background?["raw"] as? String ?? ""
                            
                            let images =
                            [ "thumb":thumb,
                              "small":small,
                              "full":full,
                              "regular":regular,
                              "raw":raw]
                            
                            let portfolioAux = Portfolio(id: id, name: name, background: images , totalBalance: totalBalance , goalAmount: goalAmount, goalDate: goalDate)
                            
                            portfoliosList.append(portfolioAux)
                        }
                        
                        observer.onNext(portfoliosList)
                    case .failure(let error):
                        observer.onError(NSError(domain: "Request Error: \(error)", code: error.responseCode ?? 0, userInfo: nil))
                    }
                }
                return Disposables.create {}
            }
    }
    
    func downloadJSONImage(imageUrl:String) -> Observable<Data> {
        return Observable.create { imgObserver -> Disposable in
            guard let url = URL(string: imageUrl) else {return imgObserver.onError(NSError(domain: "Url Invalid", code: 0, userInfo: nil)) as! Disposable}
            let request = URLRequest(url: url)
            URLSession.shared.rx.response(request: request).subscribe(onNext: {
                data in
                imgObserver.onNext(data.data)
          }).disposed(by: self.disposeBag)
        return Disposables.create {}
    }
  }
}
