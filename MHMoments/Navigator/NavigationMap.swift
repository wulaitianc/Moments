//
//  NavigationMap.swift
//  URLNavigatorExample
//
//  Created by Suyeol Jeon on 7/12/16.
//  Copyright © 2016 Suyeol Jeon. All rights reserved.
//

import SafariServices
import UIKit
import URLNavigator

enum NavigationMap {
  static func initialize(navigator: NavigatorType) {
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    navigator.register("moments://user"){ url, value, context in
        if let vc = storyboard.instantiateViewController(withIdentifier: "MHUserViewController") as? MHUserViewController {
            guard let userModel = context as? MHTweetModel.User else { return nil }
            let viewModel = MHUserViewModel(coordinator: navigator, user: userModel)
            vc.viewModel = viewModel
            
            return vc
        }
        
        return nil
    }

  }

}
