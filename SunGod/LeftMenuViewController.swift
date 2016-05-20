//
//  LeftMenuViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/18.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import SnapKit


class LeftMenuViewController: UIViewController {


    lazy var tableView = UITableView()
    lazy var cellIdentifier = "leftMenuCellID"
    lazy var mainScreenWidth = mainScreen.width / 4.0
    lazy var imageView = UIImageView()
    lazy var titleLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpImageView()
        setUpLabel()
        setUpTableView()
    }

}

extension LeftMenuViewController {
    
    func setUpView() {
        view.backgroundColor = UIColor.whiteColor()
    }
    

    
    func setUpImageView() {
        
        view.addSubview(imageView)
        imageView.snp_makeConstraints { (make) in
            
            make.width.height.equalTo(mainScreenWidth)
            make.top.equalTo(self.view.snp_top).offset(20)
            make.leading.equalTo(mainScreenWidth / 2.0)
        }
        
        imageView.backgroundColor = UIColor.blueColor()
        imageView.layer.cornerRadius = mainScreenWidth / 2
    }
    
    func setUpLabel() {
        view.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .Center
        titleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(imageView.snp_bottom).offset(25)
            make.leading.trailing.equalTo(view)
        }
        
        titleLabel.text = "ddddddd"
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
    }
}

extension LeftMenuViewController: UITableViewDelegate {

}

extension  LeftMenuViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier,forIndexPath: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
