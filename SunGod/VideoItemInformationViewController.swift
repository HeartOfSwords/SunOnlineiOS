//
//  VideoItemInformationViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/11.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import Kingfisher
import BMPlayer
import NVActivityIndicatorView

private let commitCellIdentifier = "commitCell"
private let videoCellIdentifier = "videoCell"

class VideoItemInformationViewController: UIViewController {

    private var player:BMPlayer!
    
    private let videoTitleLabel = UILabel()
    private let videoInformationLabel = UILabel()
    private let videoCommitTableView = UITableView()
    
    
    deinit {
        // 使用手势返回的时候，调用下面方法手动销毁
        player.prepareToDealloc()
    }
}

//MARK: Override
extension VideoItemInformationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setUpVideoPlayer()
        setUpView()
        setUpNav()
        setUpLabel()
        setUpTableView()
    }
    //隐藏 StatusBar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)

        player.pause(allowAutoPlay: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // 使用手势返回的时候，调用下面方法
        player.autoPlay()
    }
}

//MRAK: Function
extension VideoItemInformationViewController {
    
    
    func setUpNav() {

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
            make.trailing.leading.equalTo(self.view)
            make.top.equalTo(self.view)
            make.height.equalTo(self.view.snp_width).multipliedBy(9.0 / 16.0).priority(750)
        }
        player.backBlock =  { [unowned self] in
            self.dismissViewControllerAnimated(true, completion: { 
                
            })
        }
        //配置视频播放资源
        let videoResource = BMPlayerItemDefinitionItem(url: NSURL(string: "http://7s1rp2.com1.z0.glb.clouddn.com/1%E3%80%81HTML5%E9%9F%B3%E9%A2%91%E6%92%AD%E6%94%BE.mp4")!, definitionName: "超清")
        let item = BMPlayerItem(title: "视频的Title", resource: [videoResource], cover: "http://7u2j0x.com1.z0.glb.clouddn.com/61b207a9jw1euys0v320ej20zk0bwwg7.jpg")
        player.playWithPlayerItem(item)
        

    }
    
    func setUpView() {

    }
    
    func setUpLabel() -> Void {
        view.addSubview(videoTitleLabel)
        view.addSubview(videoInformationLabel)
        
        videoTitleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(player.snp_bottom)
            make.leading.trailing.equalTo(self.view)
        }
        
        videoInformationLabel.snp_makeConstraints { (make) in
            make.top.equalTo(videoTitleLabel.snp_bottom)
            make.leading.trailing.equalTo(self.view)
        }
        
        videoTitleLabel.text = "Title"
        videoInformationLabel.text = "InforMation"
    }
    
    func setUpTableView() -> Void {
        view.addSubview(videoCommitTableView)
        videoCommitTableView.delegate = self
        videoCommitTableView.dataSource = self
        videoCommitTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: commitCellIdentifier)
        videoCommitTableView.snp_makeConstraints { (make) in
            make.top.equalTo(videoInformationLabel.snp_bottom)
            make.bottom.leading.trailing.equalTo(self.view)
        }
    }

}



//MARK: UITableViewDelegate
extension VideoItemInformationViewController: UITableViewDelegate {
    
}
//MARK: UITableViewDataSource
extension VideoItemInformationViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(commitCellIdentifier, forIndexPath: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}




