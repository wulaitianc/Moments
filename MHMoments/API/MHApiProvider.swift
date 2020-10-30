//
//  APIManager.swift
//  SeatsBooking
//
//  Created by NAVER on 2019/7/6.
//  Copyright © 2019 Bill. All rights reserved.
//

import Foundation
import Moya
import Alamofire


enum TWAPI {
    case login
    case tweets
}


extension TWAPI: TargetType{
    var baseURL: URL {
        return URL(string: "https://thoughtworks-mobile-2018.herokuapp.com")!
    }
    
    var path: String {
        switch self {
        case .login: return "/user/jsmith"
        case .tweets: return "/user/jsmith/tweets"
        }
        
    }
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .login: fallthrough
        case .tweets: return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        switch self {
        case .login: fallthrough
        case .tweets: return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .login: fallthrough
        case .tweets: return nil
        }
    }
    
    
}
