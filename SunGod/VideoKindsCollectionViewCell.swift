//
//  VideoKindsCollectionViewCell.swift
//  SunGod
//
//  Created by 太阳在线 on 16/5/23.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit

class VideoKindsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let imageLayer = CALayer()
        imageLayer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6).CGColor
        imageLayer.frame = CGRect(x: 0, y: 0, width: mainScreen.width, height: videoViewHeight)
        self.photo.layer.addSublayer(imageLayer)
    }
    
    func setUpCell(information:String, photoURL: String) {
        
        self.titleLabel.text = information
        self.photo.kf_setImageWithURL(NSURL(string:photoURL)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
    }

}
