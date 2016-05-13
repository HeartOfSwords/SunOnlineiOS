//
//  RootViewController.swift
//  SunGod
//
//  Created by 太阳在线 on 16/4/29.
//  Copyright © 2016年 太阳在线. All rights reserved.
//  Writed by 杨晓磊

import UIKit

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadOtherViewController()
    }
    
    func loadOtherViewController() {
        let videoNavigationContgroller = UINavigationController(rootViewController: PageMenuViewController())
        videoNavigationContgroller.tabBarItem = UITabBarItem()
        let tabBarViewControllers = [videoNavigationContgroller]
        setViewControllers(tabBarViewControllers, animated: true)
    }

}
