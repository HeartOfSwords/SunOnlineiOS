//
//  MeSettingViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/30.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit

private let imageidentifier = "imagePhoto"
private let nameidentifier = "namephoto"

class MeSettingViewController: UIViewController {

    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpTableView()
    }
    
}

extension MeSettingViewController {
    
    func setUpTableView() -> Void {
        tableView = UITableView(frame: CGRectZero, style: .Grouped)
        tableView.delegate = self
        tableView.dataSource = self
        let userPhotoNib = UINib(nibName: "UserPhotoTableViewCell", bundle: nil)
        let userNameNib = UINib(nibName: "UserNameTableViewCell", bundle: nil)
        tableView.registerNib(userPhotoNib, forCellReuseIdentifier: imageidentifier)
        tableView.registerNib(userNameNib, forCellReuseIdentifier: nameidentifier)
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    func setUpView() -> Void {
        view.backgroundColor = UIColor.whiteColor()
    }
}

extension MeSettingViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCellWithIdentifier(imageidentifier, forIndexPath: indexPath) as! UserPhotoTableViewCell
            
            return cell
        default:
            let cell = tableView.dequeueReusableCellWithIdentifier(nameidentifier, forIndexPath: indexPath) as! UserNameTableViewCell
            
            return cell
        }

    }
}

extension MeSettingViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 50
        }else {
            return 44
        }
    }
}
