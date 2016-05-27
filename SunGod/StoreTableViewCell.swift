//
//  StoreTableViewCell.swift
//  SunGod
//
//  Created by xiaolei on 16/5/26.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit

class StoreTableViewCell: UITableViewCell {


    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .None
    }    
}
