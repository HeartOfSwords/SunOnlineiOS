//
//  UserSeeCacheViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/26.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit

class UserSeeCacheViewController: UIViewController {

    
    var type = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setUpView()
    }
}

// MARK: Function
extension UserSeeCacheViewController {
   private func setUpView() {
        view.backgroundColor = UIColor.whiteColor()
        switch type {
        case 0:
            title = "离线缓存"
        case 1:
            title = "我的收藏"
        default:
            title = "播放记录"
        }
    }
}
