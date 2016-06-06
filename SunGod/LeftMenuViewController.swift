//
//  LeftMenuViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/18.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit


public let leftMenuImageName = "ic_view_headline_36pt"


class LeftMenuViewController: UIViewController {


    lazy var tableView = UITableView()
    lazy var cellIdentifier = "leftMenuCellID"
    lazy var mainScreenWidth = mainScreen.width / 3.0
    lazy var imageView = UIImageView()
    lazy var titleLabel = UILabel()
    lazy var nameLabel = UILabel()
    let menutitle = ["推荐","栏目","设置"]
    
    lazy var mainViewController: UINavigationController = UINavigationController(rootViewController: VideosListCollectionViewController())
    lazy var videoKindsViewController: UIViewController = UINavigationController(rootViewController: VideosKindsViewController())
    lazy var meViewController = UIStoryboard(name: "Me", bundle: nil).instantiateInitialViewController() as! UINavigationController
    
    lazy var settingViewController: UIViewController = UINavigationController(rootViewController: SettingViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpImageView()
        setUpNameLabel()
        setUpLabel()
        setUpTableView()
        setNeedsStatusBarAppearanceUpdate()
    }
}



extension LeftMenuViewController {
    
    func setUpView() {
        //背景透明
        view.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        view.opaque = false
    }
    

    
    func setUpImageView() {
        
        view.addSubview(imageView)
        
        imageView.snp_makeConstraints { (make) in
            
            make.width.height.equalTo(mainScreenWidth)
            make.top.equalTo(self.view.snp_top).offset(40)
            make.leading.equalTo(mainScreenWidth / 2.0)
        }
        
        imageView.backgroundColor = UIColor.blueColor()
        imageView.layer.cornerRadius = mainScreenWidth / 2
    }
    
    func setUpNameLabel() {
        view.addSubview(nameLabel)
        nameLabel.numberOfLines = 0
        nameLabel.textAlignment = .Center
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(imageView.snp_bottom).offset(25)
            make.leading.trailing.equalTo(view)
        }
        
        nameLabel.text = "这块显卡有点冷"
    }
    
    func setUpLabel() {
        view.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .Center
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp_bottom).offset(15)
            make.leading.trailing.equalTo(view)
        }
        titleLabel.font = UIFont.systemFontOfSize(9)
        titleLabel.text = "我是我，我就是杨晓磊"
    }
    
    func setUpTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        tableView.snp_makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp_bottom).offset(25)
            make.leading.trailing.bottom.equalTo(self.view)
        }
        //隐藏多余的cell
        tableView.tableFooterView = UIView(frame: CGRectZero)
        //背景透明
        tableView.backgroundView = nil
        tableView.backgroundColor = UIColor.clearColor()
        tableView.opaque = false
        tableView.separatorStyle = .None
        
    }
}

extension LeftMenuViewController: UITableViewDelegate {

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            //推荐
            slideMenuController()?.changeMainViewController(mainViewController, close: true)
        case 1:
            //分类
            slideMenuController()?.changeMainViewController(videoKindsViewController, close: true)
        default:
            //Me
            slideMenuController()?.changeMainViewController(meViewController, close: true)
        }
    }
}

extension  LeftMenuViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menutitle.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,forIndexPath: indexPath)
        cell.textLabel?.text = menutitle[indexPath.row]
        cell.backgroundView = nil
        cell.backgroundColor = UIColor.clearColor()
        cell.opaque = false
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.selectionStyle = .None
        cell.textLabel?.textAlignment = .Center
        return cell
    }
    

}
