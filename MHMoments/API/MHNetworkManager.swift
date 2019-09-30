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

class MHNetWorkManager {
    static let shared = MHNetWorkManager()
    
    public func sendRequest<T>(provider: MoyaProvider<T>, target: T) -> Observable<Response>{
//        guard case DataManager.shared.reachabilityMgr.isReachable = true else { return Observable.error(MoyaError.) }
        return Observable.create{observer -> Disposable in
            provider
                .rx
                .request(target)
                .subscribe(onSuccess: {response in
                    if 200..<300 ~= response.statusCode {
                        observer.onNext(response)
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
