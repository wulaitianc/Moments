//
//  MHUserViewModel.swift
//  MHMoments
//
//  Created by NAVER on 2019/9/29.
//  Copyright © 2019 Bill. All rights reserved.
//

import Foundation
import URLNavigator
import RxSwift

struct MHUserViewModel {
    let sceneCoordinator: NavigatorType
    let user: MHTweetModel.User
    
    init(coordinator: NavigatorType, user: MHTweetModel.User) {
        self.sceneCoordinator = coordinator
        self.user = user
    }
    
    func getUserModel() -> Observable<MHTweetModel.User> {
        return Observable.just(user)
    }
}
