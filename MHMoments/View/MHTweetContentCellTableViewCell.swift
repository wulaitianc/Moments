//
//  MHTweetContentCellTableViewCell.swift
//  MHMoments
//
//  Created by NAVER on 2019/9/29.
//  Copyright © 2019 Bill. All rights reserved.
//

import UIKit

protocol MHTweetCellShowUserProtocol: class {
    func showUserPage(model: MHTweetModel.User)
}

class MHTweetContentCellTableViewCell: UITableViewCell {
    @IBOutlet weak var userNameButton: UIButton!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    weak var delegate: MHTweetCellShowUserProtocol?
    var model: MHTweetModel?

    func bindData(_ model: MHTweetModel, delegate: MHTweetCellShowUserProtocol) {
        userNameButton.setTitle(model.sender?.username, for: .normal)
        contentLabel.text = model.content
        avatarImageView.ff.setImage(urlString: model.sender?.avatar ?? "", placeholder: MHDefaultImage.placeholder)
        
        self.model = model
        self.delegate = delegate
    }

    @IBAction func userNameClicked() {
        if let model = model {
            delegate?.showUserPage(model: model.sender!)
        }
    }
}
