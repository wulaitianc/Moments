//
//  DataManager.swift
//  SeatsBooking
//
//  Created by NAVER on 2019/7/7.
//  Copyright © 2019 Bill. All rights reserved.
//

import Foundation
import Alamofire

class DataManager: NSObject {
    static let shared = DataManager()
    
    
    let reachabilityMgr = NetworkReachabilityManager(host: "www.baidu.com")!
    
}
