//
//  MHTweetSingleImageCell.swift
//  MHMoments
//
//  Created by NAVER on 2019/9/29.
//  Copyright © 2019 Bill. All rights reserved.
//

import UIKit

class MHTweetSingleImageCell: UITableViewCell {

    @IBOutlet weak var singleImageView: UIImageView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    
    func bindData(_ model: MHTweetModel.Image) {
        singleImageView.ff.setImage(urlString: model.url){[weak self] result in
            guard let self = self else{return}
            switch result {
            case .success(let image):
                let ratio =  image.size.width / image.size.height
                self.widthConstraint.constant = self.heightConstraint.constant * ratio
            case .failure(_): break
            }
        }
    }
}
