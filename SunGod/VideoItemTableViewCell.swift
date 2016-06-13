//
//  VideoItemTableViewCell.swift
//  SunGod
//
//  Created by xiaolei on 16/6/12.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit

class VideoItemTableViewCell: UITableViewCell {

    
    @IBOutlet weak var information: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(time:String, information:String, photoURL: String) {
        self.time.text = time
        self.information.text = information
        self.photo.kf_setImageWithURL(NSURL(string: photoURL)!, placeholderImage: nil)
    }
}
