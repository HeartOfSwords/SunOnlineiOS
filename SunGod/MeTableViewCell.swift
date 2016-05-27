//
//  MeTableViewCell.swift
//  SunGod
//
//  Created by xiaolei on 16/5/26.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit

class MeTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selected = false
        self.selectionStyle = .None
    }
}
