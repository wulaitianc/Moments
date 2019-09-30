//
//  TweetModel.swift
//  MHMoments
//
//  Created by NAVER on 2019/9/27.
//  Copyright © 2019 Bill. All rights reserved.
//

import Foundation

struct MHTweetModel: Codable {
    let content: String?
    let images: [Image]?
    let sender: User?
    let comments: [Comment]?
    
    struct Image: Codable {
        let url: String
    }
    struct User: Codable {
        let username: String
        let nick: String
        let avatar: String
    }
    struct Comment: Codable {
        let content: String
        let sender: User
    }
}
