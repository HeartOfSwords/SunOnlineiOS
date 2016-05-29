//
//  AppDelegate.swift
//  SunGod
//
//  Created by 太阳在线 on 16/4/27.
//  Copyright © 2016年 太阳在线. All rights reserved.
//  Writed by 杨晓磊

import UIKit
import SlideMenuControllerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        createMenuView()
        configStatusBar()
        configNav()
        print(NSHomeDirectory())
        QiNiuManager.sharedQiNiu.uploadWithName()
        return true
    }
}

private extension AppDelegate {
    
    func createMenuView() {
        
        let mainViewController = VideosListCollectionViewController()
        let leftMenuViewController = LeftMenuViewController()
        ///实例话一个 UI Nav Gation Controller
        let nav = UINavigationController(rootViewController: mainViewController)
        ///初始化一个 RootViewController 侧滑菜单
        SlideMenuOptions.leftViewWidth = mainScreen.width / 3 * 2
        ///菜单出来之后的背景颜色
///        SlideMenuOptions.opacityViewBackgroundColor = UIColor.clearColor()
        let rootViewController = SlideMenuController(mainViewController: nav, leftMenuViewController: leftMenuViewController)
///        SlideMenuOptions.
        rootViewController.delegate = mainViewController
        ///初始化UIWindow 并设置屏幕大小
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window?.backgroundColor = UIColor.whiteColor()
        ///设置 window 的 rootviewController
        window?.rootViewController = rootViewController
        /// 让window设置为主要的window，并且可见。
        window?.makeKeyAndVisible()
    }
    /**
     配置UINavigationBar
     */
    func configNav() -> Void {
        UINavigationBar.appearance().barTintColor = UIColor.blackColor()
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().translucent = false
        UINavigationBar.appearance().opaque = true
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
    }
    
    func configStatusBar() -> Void {
        /**
         为什么不能改变 statusbarstyle
         */
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        setStatusBarBackgroundColor(UIColor.blackColor())
    }
    /**
     改变status bar 的背景颜色
     
     - parameter color: 要改变的颜色
     */
    func setStatusBarBackgroundColor(color: UIColor) -> Void {
        guard let statusBar = UIApplication.sharedApplication().valueForKey("statusBarWindow")?.valueForKey("statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
}

