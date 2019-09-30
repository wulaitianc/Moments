//
//  MHTweetMultipleImageCell.swift
//  MHMoments
//
//  Created by NAVER on 2019/9/29.
//  Copyright © 2019 Bill. All rights reserved.
//

import UIKit

class MHTweetMultipleImageCell: UITableViewCell {
    @IBOutlet weak var imagesContainerView: MHTweetImageContainerView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imagesContainerView.updateImagesFrame()
        heightConstraint.constant = imagesContainerView.contentHeight
    }
    
    func bindData(_ model: [MHTweetModel.Image]) {
        let strings = model.map{$0.url}
        imagesContainerView.setImages(strings)
        heightConstraint.constant = imagesContainerView.contentHeight
    }
}
