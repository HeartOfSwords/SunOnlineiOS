//
//  VideoItemInformationViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/11.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import BMPlayer


private let commitCellIdentifier = "commitCell"
private let videoCellIdentifier = "videoCell"

class VideoItemInformationViewController: UIViewController {

    private let player = BMPlayer()
    private let commitView = UIScrollView()
    
    private let videoTitleLabel = UILabel()
    private let videoInformationLabel = UILabel()
    
    private let videoCommitTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        configBMPlayer()
        
        videoTitleLabel.text = "中国大学城的中国好声音中国大学城的中国好声音中国大学城的中国好声音中国大学城的中国好声音中国大学城的中国好声音中国大学城的中国好声音"
        videoInformationLabel.text = "太原理工大学太原理工大学太原理工大学太原理工大学太原理工大学太原理工大学太原理工大学太原理工大学太原理工大学太原理工大学太原理工大学太原理工大学"
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
        player.pause()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
        player.play()
//        player.
    }

    func configBMPlayer() {
        /**
         *  将播放视图加入到跟视图中
         */
        view.addSubview(player)
        //播放视图的布局
        player.snp_makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            // 注意此处，宽高比 16:9 优先级比 1000 低就行，在因为 iPhone 4S 宽高比不是 16：9
            make.height.equalTo(view.snp_width).multipliedBy(9.0 / 16.0)
        }
        
        let url = NSURL(string: "http://7s1rp2.com1.z0.glb.clouddn.com/1%E3%80%81HTML5%E9%9F%B3%E9%A2%91%E6%92%AD%E6%94%BE.mp4")
        //视频的播放地址
        player.playWithURL(url!)
        //返回按钮的回调
        player.backBlock = { [unowned self] in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
       
        view.addSubview(videoTitleLabel)
        videoTitleLabel.numberOfLines = 0
        
        view.addSubview(videoInformationLabel)
        videoInformationLabel.numberOfLines = 0
        
        videoTitleLabel.snp_makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(player.snp_bottom).offset(20)
        }
        
        videoInformationLabel.snp_makeConstraints { (make) in
            make.leading.trailing.equalTo(self.view)
            make.top.equalTo(videoTitleLabel.snp_bottom)
        }
        
        view.addSubview(videoCommitTableView)
        
        videoCommitTableView.delegate = self
        videoCommitTableView.dataSource = self
        
        videoCommitTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: commitCellIdentifier)
        videoCommitTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: videoCellIdentifier)
        
        videoCommitTableView.snp_makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(self.view)
            make.top.equalTo(videoInformationLabel.snp_bottom).offset(20)
        }
        view.layoutIfNeeded()
    }

}

//MARK: UITableViewDelegate
extension VideoItemInformationViewController: UITableViewDelegate {
    
}
//MARK: UITableViewDataSource
extension VideoItemInformationViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(commitCellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
