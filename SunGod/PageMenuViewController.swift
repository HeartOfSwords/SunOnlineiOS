//
//  PageMenuViewController.swift
//  SunGod
//
//  Created by 太阳在线 on 16/4/29.
//  Copyright © 2016年 太阳在线. All rights reserved.
//  Writed by 杨晓磊

import UIKit
import PageMenu
/// Page Menu View 视图控制器
class PageMenuViewController: UIViewController {

    var pageMenu : CAPSPageMenu?
    
        /// Page Menu 的配置参数
    let parameters: [CAPSPageMenuOption] = [
        //分离器的宽度
        .MenuItemSeparatorWidth(0),
        //是否使用Segment模式
        .UseMenuLikeSegmentedControl(true),
        //分离器的高度
        .MenuItemSeparatorPercentageHeight(0),
        //分离器变成小圆点
        .MenuItemSeparatorRoundEdges(false),
        //背景颜色
        .ViewBackgroundColor(UIColor.whiteColor()),
        //Menu 背景颜色
        .ScrollMenuBackgroundColor(UIColor(red: 0.44, green: 0.836, blue: 0.953, alpha: 1)),
        //横向滚动条的颜色
        .SelectionIndicatorColor(UIColor.orangeColor()),
        //选中的Menu文字颜色
        .SelectedMenuItemLabelColor(UIColor.whiteColor()),
        //未选中Menu文字颜色
        //            .UnselectedMenuItemLabelColor(UIColor(red:0.837, green:0.837, blue:0.837, alpha:1)),
        //Menu 之间的空隙颜色
        .MenuItemSeparatorColor(UIColor.whiteColor()),
        //横向滚动轨道颜色
        .BottomMenuHairlineColor(UIColor.blackColor()),
//        .MenuItemFont(UIFont(name: "OpenSans-Italic", size: 14)!),
        .EnableHorizontalBounce(true),
        .MenuItemWidthBasedOnTitleTextWidth(true)
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        pageMenuConfig()
    }
    /**
     初始化 Page Menu
     */
    func pageMenuConfig() {
        
        var controllerArray = [UIViewController]()
        
        let recommendViewController = VideosListCollectionViewController()
        recommendViewController.title = "推荐1"
        recommendViewController.contantView = self
        controllerArray.append(recommendViewController)
        
        let recommendViewController1 = ProgramaViewController()
        recommendViewController1.title = "推推荐2推荐2推荐2荐2"
        controllerArray.append(recommendViewController1)
        
        let recommendViewController2 = ProgramaViewController()
        recommendViewController2.title = "推荐3"
        controllerArray.append(recommendViewController2)
        
        let recommendViewController3 = ProgramaViewController()
        recommendViewController3.title = "推荐4"
        controllerArray.append(recommendViewController3)
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: CGRectMake(0, 63, view.frame.width, view.frame.height), pageMenuOptions: parameters)
        self.view.addSubview(pageMenu!.view)
        pageMenu!.delegate = self
        
    }



}


extension PageMenuViewController: CAPSPageMenuDelegate {
    
    func willMoveToPage(controller: UIViewController, index: Int) {
        
    }
    
    func didMoveToPage(controller: UIViewController, index: Int) {
        
    }
}