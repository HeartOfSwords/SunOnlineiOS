//
//  SettingViewController.swift
//  SunGod
//
//  Created by 太阳在线 on 16/5/23.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addLeftBarButtonWithImage(UIImage(named: leftMenuImageName)!)
        title = "设置"
    }

}
