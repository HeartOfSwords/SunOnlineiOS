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
import SwiftyJSON

private let commitCellIdentifier = "commitCell"

class VideoItemInformationViewController: UIViewController {

    private var player:BMPlayer!
    
    private let videoTitleLabel = UILabel()
    private let videoInformationLabel = UILabel()
    private let videoCommitTableView = UITableView()
    private let shareButton = UIButton()
    private let commitTextField = UITextField()
    
    var videoID = "123"
    var commits = [WilddogCommiteModel]()
    
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
        setUpButton()
        setUpTableView()
        setUpText()
        setUpWilldog()
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
    
    func setUpWilldog() -> Void {
        WilddogManager.wilddogLogin()
        let videoRef = WilddogManager.ref.childByAppendingPath(videoID)
                /// 添加新的留言
        let one = WilddogCommiteModel(autherName: "杨晓磊", autherID: "123", commiteTime: String(NSDate()), commiteValue: "这是我留的言", autherImageURL: "")
                /// 生成一个唯一的 Key 值
        let messageKey = one.commiteTime + one.autherID
                /// JSON
        let value = ["autherID":one.autherID,"autherName":one.autherName,"comiteTime":one.commiteTime,"commiteValue":one.commiteValue,"imageURL":one.autherImageURL]
        
        videoRef.updateChildValues([messageKey:value])
        //监听节点的变化
        videoRef.queryLimitedToLast(3).observeEventType(.Value, withBlock: { (shot) in
            let dataJSON = JSON(shot.value)
            for (_,value) in dataJSON {
            let teo = WilddogCommiteModel(
                autherName: value["autherName"].stringValue,
                autherID:  value["autherID"].stringValue,
                commiteTime: value["commiteTime"].stringValue,
                commiteValue: value["commiteValue"].stringValue,
                autherImageURL: value["imageURL"].stringValue
                )
                self.commits.append(teo)
                self.videoCommitTableView.reloadData()
            }
            
            }) { (error) in
                
        }
    }
    
    func setUpVideoPlayer() {
        
        BMPlayerConf.allowLog = false
        // 是否自动播放，默认true
        BMPlayerConf.shouldAutoPlay = false
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
    
    func setUpButton() -> Void {
        
    }
    
    func setUpTableView() -> Void {
        view.addSubview(videoCommitTableView)
        videoCommitTableView.estimatedRowHeight = 88
        videoCommitTableView.rowHeight = UITableViewAutomaticDimension
        videoCommitTableView.delegate = self
        videoCommitTableView.dataSource = self
        videoCommitTableView.registerNib(UINib(nibName: "CommitTableViewCell",bundle: nil), forCellReuseIdentifier: commitCellIdentifier)
        videoCommitTableView.snp_makeConstraints { (make) in
            make.top.equalTo(videoInformationLabel.snp_bottom)
            make.leading.trailing.equalTo(self.view)
        }
    }
    
    func setUpText() -> Void {
        view.addSubview(commitTextField)
        commitTextField.snp_makeConstraints { (make) in
            make.top.equalTo(self.videoCommitTableView.snp_bottom)
            make.leading.bottom.equalTo(self.view)
        }
    }

}



//MARK: UITableViewDelegate
extension VideoItemInformationViewController: UITableViewDelegate {

}
//MARK: UITableViewDataSource
extension VideoItemInformationViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(commitCellIdentifier, forIndexPath: indexPath) as! CommitTableViewCell
        let indexCommit = commits[indexPath.row]
        cell.configCell(imageURL: indexCommit.autherImageURL, commitDate: indexCommit.commiteTime, userName: indexCommit.autherName, commitValue: indexCommit.commiteValue)
        return cell
    }
}




