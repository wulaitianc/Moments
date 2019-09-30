//
//  UserInfoModel.swift
//  Moments
//
//  Created by NAVER on 2019/9/26.
//  Copyright © 2019 Bill. All rights reserved.
//

import Foundation

struct MHUserInfoModel: Codable {
    let profile_image: String
    let avatar: String
    let nick: String
    let username: String
    
    enum CodingKeys: String, CodingKey {
        case profile_image = "profile-image"
        case avatar
        case nick
        case username
    }
}
