//
//  VideoItemInformationViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/11.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import BMPlayer
import NVActivityIndicatorView
import SwiftyJSON


private let commitCellIdentifier = "commitCell"

class VideoItemInformationViewController: UIViewController {

    private var player:BMPlayer!
    
    private let videoTitleLabel = UILabel()
    private let videoInformationLabel = UILabel()
    private let videoCommitTableView = UITableView()
    private let commitTextView = UITextField()
    private let userImage = UIImageView()
    
    private let sendButton = UIButton()
    
    private let storeButton = UIButton()
    private let shareButton = UIButton()
    private let downButton = UIButton()
    private let delyButton = UIButton()
    
    var videoID = "123"
    var commits = [WilddogCommiteModel]()
    var commitValue = ""
    
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
        setUpButtons()
        setUpImage()
        setUpText()
        setUpSendButton()
        setUpTableView()
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
        
        //监听节点的变化
        videoRef.queryLimitedToLast(100).observeEventType(.Value, withBlock: { (shot) in
            guard let value = shot.value else {return}
            let dataJSON = JSON(value)
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
            
            self.commitTextView.resignFirstResponder()
            self.dismissViewControllerAnimated(true, completion: { 
                
            })
        }
        //配置视频播放资源
        let videoResource = BMPlayerItemDefinitionItem(url: NSURL(string: "http://7s1rp2.com1.z0.glb.clouddn.com/1%E3%80%81HTML5%E9%9F%B3%E9%A2%91%E6%92%AD%E6%94%BE.mp4")!, definitionName: "超清")
        let item = BMPlayerItem(title: "视频的Title", resource: [videoResource], cover: "http://7u2j0x.com1.z0.glb.clouddn.com/61b207a9jw1euys0v320ej20zk0bwwg7.jpg")
        player.playWithPlayerItem(item)
        

    }
    
    func setUpView() {
        view.backgroundColor = UIColor.whiteColor()
    }
    
    func setUpLabel() -> Void {
        view.addSubview(videoTitleLabel)
        view.addSubview(videoInformationLabel)
        
        videoTitleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(player.snp_bottom).offset(8)
            make.leading.trailing.equalTo(self.view).offset(8)
        }
        
        videoInformationLabel.snp_makeConstraints { (make) in
            make.top.equalTo(videoTitleLabel.snp_bottom).offset(8)
            make.leading.trailing.equalTo(self.view).offset(8)
        }
        
        videoTitleLabel.text = "这里是视频的标题"
        videoInformationLabel.text = "这里是视频的详细内容"
    }
    
    func setUpButtons() -> Void {
        view.addSubview(storeButton)
        view.addSubview(shareButton)
        view.addSubview(downButton)
        view.addSubview(delyButton)
        
        storeButton.snp_makeConstraints { (make) in
            
            make.width.height.equalTo(25)
            make.top.equalTo(videoInformationLabel.snp_bottom).offset(18)
            make.trailing.equalTo(shareButton.snp_leading).offset(-8)
        }
        
        shareButton.snp_makeConstraints { (make) in
            make.top.equalTo(storeButton.snp_top)
            make.width.height.equalTo(storeButton)
            make.trailing.equalTo(downButton.snp_leading).offset(-8)
        }
        
        downButton.snp_makeConstraints { (make) in
            make.top.equalTo(storeButton.snp_top)
            make.width.height.equalTo(storeButton)
            make.trailing.equalTo(delyButton.snp_leading).offset(-8)
        }
        
        delyButton.snp_makeConstraints { (make) in
            make.trailing.equalTo(self.view).offset(-8)
            make.width.height.equalTo(storeButton)
            make.top.equalTo(storeButton.snp_top)
        }
        
        storeButton.backgroundColor = UIColor.blueColor()
        shareButton.backgroundColor = UIColor.blueColor()
        downButton.backgroundColor = UIColor.blueColor()
        delyButton.backgroundColor = UIColor.blueColor()
    }
    
    func setUpImage() -> Void {
        view.addSubview(userImage)
        userImage.snp_makeConstraints { (make) in
            make.top.equalTo(self.storeButton.snp_bottom).offset(18)
            make.leading.equalTo(self.view).offset(8)
            make.height.width.equalTo(25)
        }
        
        userImage.backgroundColor = UIColor.blueColor()
    }
    
    func setUpText() -> Void {
        view.addSubview(commitTextView)
        commitTextView.snp_makeConstraints { (make) in
            make.top.equalTo(userImage.snp_top)
            make.leading.equalTo(self.userImage.snp_trailing).offset(8)
            make.height.equalTo(userImage.snp_height)
        }
        commitTextView.delegate = self
        commitTextView.returnKeyType = .Send
        commitTextView.enablesReturnKeyAutomatically = true
        commitTextView.placeholder = "写下你的评论"
    }
    
    func setUpSendButton() -> Void {
        view.addSubview(sendButton)
        sendButton.snp_makeConstraints { (make) in
            make.leading.equalTo(commitTextView.snp_trailing).offset(8)
            make.top.equalTo(userImage.snp_top)
            make.trailing.equalTo(self.view).offset(-8)
            make.height.width.equalTo(userImage)
        }
        
        sendButton.setTitle("发送", forState: UIControlState.Highlighted)
        sendButton.backgroundColor = UIColor.blueColor()
    }
    
    func setUpTableView() -> Void {
        
        view.addSubview(videoCommitTableView)
        videoCommitTableView.estimatedRowHeight = 88
        videoCommitTableView.rowHeight = UITableViewAutomaticDimension
        videoCommitTableView.delegate = self
        videoCommitTableView.dataSource = self
        videoCommitTableView.registerNib(UINib(nibName: "CommitTableViewCell",bundle: nil), forCellReuseIdentifier: commitCellIdentifier)
        videoCommitTableView.snp_makeConstraints { (make) in
            make.top.equalTo(userImage.snp_bottom).offset(10)
            make.leading.trailing.bottom.equalTo(self.view)
        }
    }
}



//MARK: UITableViewDelegate
extension VideoItemInformationViewController: UITableViewDelegate{

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

extension VideoItemInformationViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        commitValue = textField.text!
        
        let videoRef = WilddogManager.ref.childByAppendingPath(videoID)
        
        /// 添加新的留言
        let one = WilddogCommiteModel(autherName: "杨晓磊", autherID: "123", commiteTime: String(NSDate()), commiteValue: commitValue, autherImageURL: "")
        /// 生成一个唯一的 Key 值
        let messageKey = one.commiteTime + one.autherID
        /// JSON
        let value = ["autherID":one.autherID,"autherName":one.autherName,"comiteTime":one.commiteTime,"commiteValue":one.commiteValue,"imageURL":one.autherImageURL]
        
        videoRef.updateChildValues([messageKey:value])
        textField.text = ""
        commitValue = ""
        commits = []
        return true
    }
}






