//
//  MeViewController.swift
//  SunGod
//
//  Created by 太阳在线 on 16/5/23.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import SnapKit

private let userCell = "userCell"
private let storeCell = "storeCell"
private let allowCell = "allowCell"

class MeViewController: UIViewController {

    
    var tablView: UITableView!
    let con = UserSeeCacheViewController()
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
        view.addSubview(tablView)
        
        tablView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    
}

extension MeViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        switch indexPath.section {
        case 0:
            return
        case 1:

            switch indexPath.row {
            case 0:
                presentViewController(con, animated: true, completion: {
                    
                })
            case 1:
                presentViewController(con, animated: true, completion: {
                    
                })
            default:
                presentViewController(con, animated: true, completion: {
                    
                })
            }
        default:
            return
        }
    }
}

extension MeViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
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
            return 0
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
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(allowCell, forIndexPath: indexPath) as! AllowDownTableViewCell
            configAllowDownCell(cell, indexPath: indexPath)
            return cell
        }
    }
}

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
        print(sender.on)
    }
    
    func allDown(sender: UISwitch) {
        print(sender.on)
    }
}
