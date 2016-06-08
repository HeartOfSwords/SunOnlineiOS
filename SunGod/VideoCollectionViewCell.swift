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
        
    }
    
    func setUpCell(time:String, information:String, photoURL: String) {
        self.time.text = time
        self.information.text = information
        self.photo.kf_setImageWithURL(NSURL(string: photoURL)!, placeholderImage: nil)
    }
    
    

}
