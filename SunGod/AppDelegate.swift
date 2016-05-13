//
//  AppDelegate.swift
//  SunGod
//
//  Created by 太阳在线 on 16/4/27.
//  Copyright © 2016年 太阳在线. All rights reserved.
//  Writed by 杨晓磊

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //初始化UIWindow 并设置屏幕大小
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        //初始化一个 RootViewController
        let rootViewController = RootViewController()
        //设置 window 的 rootviewController
        window?.rootViewController = rootViewController
        //让window设置为主要的window，并且可见。
        window?.makeKeyAndVisible()
        return true
    }
}

