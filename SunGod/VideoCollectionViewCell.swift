//
//  VideoCollectionViewCell.swift
//  SunGod
//
//  Created by xiaolei on 16/5/11.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import Kingfisher

class VideoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let imageLayer = CALayer()
        imageLayer.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.6).CGColor
        imageLayer.frame = CGRect(x: 0, y: 0, width: mainScreen.width, height: videoViewHeight)
        self.photo.layer.addSublayer(imageLayer)
        
    }
    
    func setUpCell(time:String, information:String, photoURL: String) {
        self.time.text = time
        self.information.text = information
        self.photo.kf_setImageWithURL(NSURL(string:photoURL)!, placeholderImage: nil, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
    }
    
    

}
