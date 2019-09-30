//
//  MHTweetCommentCell.swift
//  MHMoments
//
//  Created by NAVER on 2019/9/29.
//  Copyright © 2019 Bill. All rights reserved.
//

import UIKit

class MHTweetCommentCell: UITableViewCell {
    @IBOutlet weak var userNameButton: UIButton!
    @IBOutlet weak var commentLabel: UILabel!
    weak var delegate: MHTweetCellShowUserProtocol?
    var model: MHTweetModel.User?
    
    func bindData(_ model: MHTweetModel.Comment, delegate: MHTweetCellShowUserProtocol) {
        let username = model.sender.username + ":"
        userNameButton.setTitle(username, for: .normal)
        let attributedString = NSMutableAttributedString(string: username + ":" + model.content)
        attributedString.addAttributes([.foregroundColor: UIColor.clear], range: NSMakeRange(0, username.count + 1))
        commentLabel.attributedText = attributedString
        
        self.delegate = delegate
        self.model = model.sender
    }
    
    @IBAction func userNameClicked() {
        if let model = model {
            delegate?.showUserPage(model: model)
        }
    }
}
