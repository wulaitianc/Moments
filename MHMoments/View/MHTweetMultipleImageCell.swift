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
    }
    
    func bindData(_ model: [MHTweetModel.Image]) {
        let strings = model.map{$0.url}
        imagesContainerView.setImages(strings)
                
        imagesContainerView.translatesAutoresizingMaskIntoConstraints = false
        imagesContainerView.removeFromSuperview()
        addSubview(imagesContainerView)
        
        let imageRows = ceilf(Float(strings.count) / Float(MHTweetStatics.tweetsInOneRow))
        let topConstraint = NSLayoutConstraint(item: imagesContainerView!,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: imagesContainerView.superview!,
                                                      attribute: .top,
                                                      multiplier: 1,
                                                      constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: imagesContainerView!,
                                                    attribute: .leading,
                                                    relatedBy: .equal,
                                                    toItem: imagesContainerView.superview!,
                                                    attribute: .leading,
                                                    multiplier: 1,
                                                    constant: 66)
        let bottomConstrant = NSLayoutConstraint(item: imagesContainerView!,
                                                 attribute: .bottom,
                                                 relatedBy: .equal,
                                                 toItem: imagesContainerView.superview!,
                                                 attribute: .bottom,
                                                 multiplier: 1,
                                                 constant: 2)
        let widthConstraint = NSLayoutConstraint(item: imagesContainerView!,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: imagesContainerView.superview!,
                                                 attribute: .width,
                                                 multiplier: 1,
                                                 constant: -96)
        let heightConstraint = NSLayoutConstraint(item: imagesContainerView!,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: imagesContainerView.superview!,
                                                  attribute: .width,
                                                  multiplier: CGFloat(imageRows / 3),
                                                  constant: -32 * CGFloat(imageRows))
            
        imagesContainerView.superview!.addConstraints([topConstraint, leadingConstraint, bottomConstrant, widthConstraint, heightConstraint])
        }
    }

