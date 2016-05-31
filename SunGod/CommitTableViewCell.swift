//
//  CommitTableViewCell.swift
//  SunGod
//
//  Created by xiaolei on 16/5/27.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import Kingfisher

class CommitTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var commitTime: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var commitValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
    }

    func configCell(imageURL image: String, commitDate: String, userName: String, commitValue: String) {
        photoImage.kf_setImageWithURL(NSURL(string: image)!, placeholderImage: Image(named: leftMenuImageName))
        commitTime.text = commitDate
        name.text = userName
        self.commitValue.text = commitValue
    }
    
}
