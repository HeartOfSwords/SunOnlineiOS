//
//  MeViewController.swift
//  SunGod
//
//  Created by 太阳在线 on 16/5/23.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import SwiftyUserDefaults

private let userCell = "userCell"
private let storeCell = "storeCell"
private let allowCell = "allowCell"
private let loginCell = "loginCell"

class MeViewController: UIViewController {

    
    var tablView: UITableView!
    lazy var con:UserSeeCacheViewController = UserSeeCacheViewController()
    lazy var meSetting: MeSettingViewController = MeSettingViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNav()
        setUpTableView()
        title = "ME"

    }
    
    func setUpNav() -> Void {
        addLeftBarButtonWithImage(UIImage(named: leftMenuImageName)!)
    }
    
    func setUpTableView() -> Void {
        tablView = UITableView(frame: CGRectZero, style: .Grouped)
        tablView.delegate = self
        tablView.dataSource = self
        let meNib = UINib(nibName: "MeTableViewCell", bundle: nil)
        let storNib = UINib(nibName: "StoreTableViewCell", bundle: nil)
        let downNib = UINib(nibName: "AllowDownTableViewCell", bundle: nil)
        tablView.registerNib(meNib, forCellReuseIdentifier: userCell)
        tablView.registerNib(storNib, forCellReuseIdentifier: storeCell)
        tablView.registerNib(downNib, forCellReuseIdentifier: allowCell)
        tablView.registerClass(UITableViewCell.self, forCellReuseIdentifier: loginCell)
        view.addSubview(tablView)
        
        tablView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    
}

//MARK: UITableViewDelegate
extension MeViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            navigationController?.pushViewController(meSetting, animated: true)
        case 1:

            switch indexPath.row {
            case 0:
                con.type = 0
                navigationController?.pushViewController(meSetting, animated: true)
            case 1:
                con.type = 1
                navigationController?.pushViewController(con, animated: true)
            default:
                con.type = 2
                navigationController?.pushViewController(con, animated: true)
            }
        case 2:
            return
        default:
            return
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
}


//MARK: UITableViewDataSource
extension MeViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(userCell, forIndexPath: indexPath) as! MeTableViewCell
            cell.userName.text = "这块显卡有点冷"
            cell.userImage.image = UIImage(named: leftMenuImageName)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCellWithIdentifier(storeCell, forIndexPath: indexPath) as! StoreTableViewCell
            configStoreCell(cell, indexPath: indexPath)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCellWithIdentifier(allowCell, forIndexPath: indexPath) as! AllowDownTableViewCell
            configAllowDownCell(cell, indexPath: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(loginCell, forIndexPath: indexPath)
            
            if Defaults[.userisLogin].boolValue {
                cell.textLabel?.text = "退出登录"
            }else {
                cell.textLabel?.text = "登录"
            }
            
            return cell
        }
    }
}

//MARK: Function
extension MeViewController {
    
    func configStoreCell(cell: StoreTableViewCell, indexPath: NSIndexPath) -> Void {
        switch indexPath.row {
        case 0:
            configCellValue(cell, imageName: leftMenuImageName, textValue: "离线缓存")
        case 1:
            configCellValue(cell, imageName: leftMenuImageName, textValue: "我的收藏")
        default:
            configCellValue(cell, imageName: leftMenuImageName, textValue: "播放记录")
        }
    }
    
    func configCellValue(cell:StoreTableViewCell, imageName: String, textValue: String)  {
        cell.iconImage.image = UIImage(named: imageName)
        cell.name.text = textValue
    }
    
    func configAllowDownCell(cell: AllowDownTableViewCell, indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            cell.name.text = "允许2G/3G/4G观看"
            cell.switchButton.addTarget(self, action: #selector(allSee(_:)), forControlEvents: UIControlEvents.ValueChanged)
        default:
            cell.name.text = "允许2G/3G/4G缓存"
            cell.switchButton.addTarget(self, action: #selector(allDown(_:)), forControlEvents: UIControlEvents.ValueChanged)
        }
    }
    
    func allSee(sender: UISwitch) {
        Defaults[.allowSee] = sender.on
        Defaults.synchronize()
    }
    
    func allDown(sender: UISwitch) {
        Defaults[.allowDown] = sender.on
        Defaults.synchronize()
    }
}
