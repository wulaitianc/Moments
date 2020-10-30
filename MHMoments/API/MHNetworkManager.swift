//
//  NetworkManager.swift
//  SeatsBooking
//
//  Created by NAVER on 2019/7/6.
//  Copyright © 2019 Bill. All rights reserved.
//

import Foundation
import Moya
import RxSwift

let provider = MoyaProvider<MultiTarget>(callbackQueue: DispatchQueue.main)

class MHNetWorkManager {
    static let shared = MHNetWorkManager()
    
    public func sendRequest<T: Decodable>(_ target: TargetType) -> Observable<T>{
        return Observable.create{observer -> Disposable in
            provider
                .rx
                .request(MultiTarget(target))
                .subscribe(onSuccess: {response in
                    if 200..<300 ~= response.statusCode {
                        do {
                            let model = try response.map(T.self)
                            observer.onNext(model)
                        } catch {
                            //map object failed
                            observer.onError(MoyaError.objectMapping(error, response))
                        }
                    }else{
                        //success request with error msg
                        let error = MoyaError.statusCode(response)
                        observer.onError(error)
                    }
                },
                           onError: {error in
                            //request failed
                            observer.onError(error)
                })
        }
    }
    
    
}
