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
        setUpView()
    }
}

// MARK: Function
extension UserSeeCacheViewController {
   private func setUpView() {
        view.backgroundColor = UIColor.whiteColor()
        switch type {
        case 0:
            print("")
        default:
            print("")
        }
    }
}
