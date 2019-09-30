//
//  MHTweetImageContainerView.swift
//  MHMoments
//
//  Created by NAVER on 2019/9/27.
//  Copyright © 2019 Bill. All rights reserved.
//

import UIKit

class MHTweetImageContainerView: UIView {
    private let gapBetweenImages: CGFloat = 5
    private let imagesInOneRow = 3
    
    func setImages(_ images:[String]) {
        let imagesToCreate = images.count - subviews.count
        //更新已有的UIImageView
        for (i, subview) in subviews.enumerated(){
            guard i < images.count else {break}
            let imageView = (subview as! UIImageView)
            imageView.ff.setImage(urlString: images[i])
            imageView.isHidden = false
        }

        if imagesToCreate >= 0 {
            let existedImageViewCount = subviews.count
            //需要初始化额外的UIImageView
            
            for i in 0..<imagesToCreate {
                let imageViewCount = existedImageViewCount + i
                let imageView = UIImageView(frame: CGRect(x: CGFloat(imageViewCount % imagesInOneRow) * (imageWidth + gapBetweenImages),
                                                          y: CGFloat(imageViewCount / imagesInOneRow) * (imageWidth + gapBetweenImages),
                                                          width: imageWidth,
                                                          height: imageWidth))
                imageView.ff.setImage(urlString: images[imageViewCount])
                addSubview(imageView)
            }
        }else{
            //subviews中的UIImageView过多，需要隐藏
            let startIndex = images.count
            for i in startIndex ..< subviews.count {
                subviews[i].isHidden = true
            }
        }
    }
    
    //变更朝向后更新UIImageView的frame
    func updateImagesFrame() {
        for (i,subview) in subviews.enumerated() {
            subview.frame = CGRect(x: CGFloat(i % imagesInOneRow) * (imageWidth + gapBetweenImages),
                                   y: CGFloat(i / imagesInOneRow) * (imageWidth + gapBetweenImages),
                                   width: imageWidth,
                                   height: imageWidth)
        }
    }
    
    var imageWidth: CGFloat{
        return (UIScreen.main.bounds.width - 86 - gapBetweenImages * CGFloat(imagesInOneRow - 1)) / CGFloat(imagesInOneRow)
    }
    
    var contentHeight: CGFloat{
        var imagesShown = 0
        for i in 0 ..< subviews.count {
            if subviews[i].isHidden {
                break
            }
            imagesShown += 1
        }
        
        let rows = ceilf(Float(imagesShown) / Float(imagesInOneRow))
        
        return CGFloat(roundf(Float(CGFloat(rows) * imageWidth + CGFloat(rows - 1) * gapBetweenImages)))
    }

}
