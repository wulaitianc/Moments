//
//  MHUserViewController.swift
//  MHMoments
//
//  Created by NAVER on 2019/9/29.
//  Copyright © 2019 Bill. All rights reserved.
//

import UIKit
import RxSwift

class MHUserViewController: UIViewController {
    var viewModel: MHUserViewModel!
    let disposeBag = DisposeBag()

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        updateUI()
    }
    
    func updateUI() {
        viewModel
            .getUserModel()
            .subscribe(onNext: {[weak self] model in
                guard let self = self else {return}
                
                self.avatarImageView.ff.setImage(urlString: model.avatar)
                self.userNameLabel.text = model.username
            })
            .disposed(by: disposeBag)
    }

}
