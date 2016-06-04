//
//  VideoViewController.swift
//  SunGod
//
//  Created by 太阳在线 on 16/6/1.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import SlackTextViewController
import BMPlayer
import NVActivityIndicatorView

class VideoViewController: SLKTextViewController {

    
    private var player:BMPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpVideoPlayer()
        
        
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "textcell")
        tableView?.snp_makeConstraints(closure: { (make) in
            make.top.equalTo(player.snp_bottom)
            make.leading.trailing.bottom.equalTo(self.view)
        })
    }


    func setUpVideoPlayer() {
        
        BMPlayerConf.allowLog = false
        // 是否自动播放，默认true
        BMPlayerConf.shouldAutoPlay = true
        // 主体颜色，默认白色
        BMPlayerConf.tintColor = UIColor.whiteColor()
        // 顶部返回和标题显示选项，默认.Always，可选.HorizantalOnly、.None
        BMPlayerConf.topBarShowInCase = .Always
        // 加载效果，更多请见：https://github.com/ninjaprox/NVActivityIndicatorView
        BMPlayerConf.loaderType  = NVActivityIndicatorType.BallRotateChase
        
        player = BMPlayer()
        view.addSubview(player)
        player.snp_makeConstraints { (make) in
            make.top.trailing.leading.equalTo(self.view)
            make.height.equalTo(self.view.snp_width).multipliedBy(9.0 / 16.0)
        }
        player.backBlock =  { [unowned self] in
            
//            self.commitTextView.resignFirstResponder()
            self.dismissViewControllerAnimated(true, completion: {
                
            })
        }
        //配置视频播放资源
        let videoResource = BMPlayerItemDefinitionItem(url: NSURL(string: "http://7s1rp2.com1.z0.glb.clouddn.com/1%E3%80%81HTML5%E9%9F%B3%E9%A2%91%E6%92%AD%E6%94%BE.mp4")!, definitionName: "超清")
        let item = BMPlayerItem(title: "视频的Title", resource: [videoResource], cover: "http://7u2j0x.com1.z0.glb.clouddn.com/61b207a9jw1euys0v320ej20zk0bwwg7.jpg")
        player.playWithPlayerItem(item)
        
        
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("textcell", forIndexPath: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    
}
