//
//  UIViewController+Toast.swift
//  Moments
//
//  Created by NAVER on 2019/9/26.
//  Copyright © 2019 Bill. All rights reserved.
//

import Foundation
import Toast_Swift

extension UIViewController{
    func showMessage(_ msg: String?) {
        if let msg = msg{
            view.makeToast(msg, duration: 1, position: .center)
        }
    }
    
    func showLoading() {
        view.makeToastActivity(.center)
    }
    
    func hideLoading() {
        view.hideToastActivity()
    }
}
