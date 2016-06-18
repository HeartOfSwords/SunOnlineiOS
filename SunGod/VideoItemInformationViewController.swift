//
//  VideoItemInformationViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/11.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import SwiftyJSON
import BMPlayer
import NVActivityIndicatorView
import MonkeyKing
import PopMenu
import PKHUD
import Kingfisher
import Gifu
private let commitCellIdentifier = "commitCell"

class VideoItemInformationViewController: UIViewController {

    var video: VideoItemModel!
    var anotherVideo: VideoItemModel!
    
    private var player:BMPlayer!
    private let videoTitleLabel = UILabel()
    private let videoInformationLabel = UILabel()
    private let storeButton = UIButton()
    private let shareButton = UIButton()
    private let downButton = UIButton()
    private let delyButton = UIButton()
    private let timeLabel = UILabel()
    private let seeNumberLabel = UILabel()
    private let antoherViewVideo = UIView()
    private let gifImageView: AnimatableImageView = AnimatableImageView()
        /// 分享界面的按钮
    let wechatmenItem = MenuItem(title: "微信 朋友圈", iconName: "care", index: 0)
    let weiboMenItem = MenuItem(title: "微博", iconName: "care", index: 1)
    let qqMenitem = MenuItem(title: "QQ 好友", iconName: "care", index: 2)
    let qqTimeLint = MenuItem(title: "QQ 空间", iconName: "care", index: 3)
    var popMenu: PopMenu!
    
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
//        setupAnotherVideoView()
        setUpGIF()
        setupValue()
        
    }
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
//        view.backgroundColor = UIColor.grayColor().colorWithAlphaComponent(0.2)
    }
    

}

////MRAK: Function
extension VideoItemInformationViewController {
  
    func setUpNav() {

    }
    
    func setUpVideoPlayer() {
        
        BMPlayerConf.allowLog = false
        // 是否自动播放，默认true
        BMPlayerConf.shouldAutoPlay = true
        // 主体颜色，默认白色
        BMPlayerConf.tintColor = UIColor.whiteColor()
        // 显示慢放和镜像按钮
//        BMPlayerConf.slowAndMirror = true
        // 顶部返回和标题显示选项，默认.Always，可选.HorizantalOnly、.None
        BMPlayerConf.topBarShowInCase = .Always
        // 加载效果，更多请见：https://github.com/ninjaprox/NVActivityIndicatorView
        BMPlayerConf.loaderType  = NVActivityIndicatorType.BallRotateChase
        
        player = BMPlayer()
        view.addSubview(player)
        player.snp_makeConstraints { (make) in
            make.top.trailing.leading.equalTo(self.view)
            make.height.equalTo(self.view.snp_width).multipliedBy(9.0 / 16.0).priority(750)
        }
        
        player.backBlock = { [unowned self] in
            
            self.dismissViewControllerAnimated(true, completion: {
                
            })
        }
        
        //配置视频播放资源
        let videoResource = BMPlayerItemDefinitionItem(url: NSURL(string: self.video.videoURL)!, definitionName: "太阳在线")
        let item = BMPlayerItem(title: self.video.videoTitle, resource: [videoResource], cover: self.video.videoImageURL)
        player.playWithPlayerItem(item)
    }

    func setUpView() {
        view.backgroundColor = UIColor.whiteColor()
        //MARK: 分享按钮
        popMenu = PopMenu(frame: CGRectMake(0, 0, mainScreen.size.width, mainScreen.size.height), items: [wechatmenItem,weiboMenItem,qqMenitem,qqTimeLint])
        popMenu.menuAnimationType = .Sina
        popMenu.perRowItemCount = 3
        /**
         *  分享界面 按钮点击之后的操作
         */
        popMenu.didSelectedItemCompletion = {
            menuItem in
            switch menuItem.index {
            case 0:
                self.shareWeChat()
            case 1:
                self.shareWeiBo()
            case 2:
                self.shareQQ()
            case 3:
                self.shareQQDataLing()
            default:
                break
            }
        }
        
        /**
         记录播放
         */
        
        VideoItemModel.saveVideoItemModel(video) { (res) in
            //保存之后的动作
        }
    }
    
    func setUpLabel() -> Void {
        
        
        let image0 = UIImageView()
        let image1 = UIImageView()
        image0.image = UIImage(named: "眼睛-1")
        image1.image = UIImage(named: "记录")
        view.addSubview(image0)
        view.addSubview(image1)
        
        videoTitleLabel.font = UIFont.boldSystemFontOfSize(18)
        
        videoInformationLabel.font = UIFont.italicSystemFontOfSize(12)
        videoInformationLabel.numberOfLines = 0
        
        seeNumberLabel.font = UIFont.systemFontOfSize(10)
        timeLabel.font = UIFont.systemFontOfSize(10)
        
        view.addSubview(videoTitleLabel)
        view.addSubview(videoInformationLabel)
        view.addSubview(seeNumberLabel)
        view.addSubview(timeLabel)
        
        videoTitleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(player.snp_bottom).offset(8)
            make.leading.equalTo(self.view).offset(8)
            make.trailing.equalTo(-8)
        }
        
        videoInformationLabel.snp_makeConstraints { (make) in
            make.top.equalTo(videoTitleLabel.snp_bottom).offset(8)
            make.leading.equalTo(self.view).offset(8)
            make.trailing.equalTo(-8)
        }
        
        image0.snp_makeConstraints { (make) in
            make.width.equalTo(17)
            make.height.equalTo(10)
            make.top.equalTo(self.videoInformationLabel.snp_bottom).offset(6)
            make.leading.equalTo(videoInformationLabel.snp_leading)
        }
        
        seeNumberLabel.snp_makeConstraints { (make) in
            make.leading.equalTo(image0.snp_trailing).offset(10)
            make.bottom.equalTo(image0.snp_bottom)
        }
        
        image1.snp_makeConstraints { (make) in
            make.top.equalTo(image0.snp_top)
            make.trailing.equalTo(timeLabel.snp_leading).offset(-10)
//            make.leading.equalTo(seeNumberLabel.snp_trailing).offset(30)
            make.width.height.equalTo(10)
        }
        timeLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(image1.snp_bottom)
            make.trailing.equalTo(view.snp_trailing).offset(-8)
        }
    }

    func setUpButtons() -> Void {
        
        view.addSubview(storeButton)
        view.addSubview(shareButton)
        view.addSubview(downButton)
        view.addSubview(delyButton)
        let fontSize:CGFloat = 8
        let label0 = UILabel()
        label0.textAlignment = .Center
        label0.font = UIFont.systemFontOfSize(fontSize)
        label0.text = "收藏"
        let label1 = UILabel()
        label1.textAlignment = .Center
        label1.font = UIFont.systemFontOfSize(fontSize)
        label1.text = "分享"
        let label2 = UILabel()
        label2.textAlignment = .Center
        label2.font = UIFont.systemFontOfSize(fontSize)
        label2.text = "下载"
        let label3 = UILabel()
        label3.textAlignment = .Center
        label3.font = UIFont.systemFontOfSize(fontSize)
        label3.text = "评论"
        view.addSubview(label0)
        view.addSubview(label1)
        view.addSubview(label2)
        view.addSubview(label3)
        
        let width = 18
        let padding = (mainScreen.size.width - 18 * 6) / 3
        storeButton.snp_makeConstraints { (make) in
            
            make.width.equalTo(width)
            make.height.equalTo(width)
            make.top.equalTo(seeNumberLabel.snp_bottom).offset(12)
            make.leading.equalTo(18)
            
        }
        
        label0.snp_makeConstraints { (make) in
            make.width.equalTo(width)
            make.top.equalTo(storeButton.snp_bottom)
            make.leading.equalTo(storeButton.snp_leading)
        }
        
        shareButton.snp_makeConstraints { (make) in
            make.top.equalTo(storeButton.snp_top)
            make.width.height.equalTo(storeButton)
            make.leading.equalTo(storeButton.snp_trailing).offset(padding)
        }
        
        label1.snp_makeConstraints { (make) in
            make.width.equalTo(width)
            make.top.equalTo(shareButton.snp_bottom)
            make.leading.equalTo(shareButton.snp_leading)
        }
        
        downButton.snp_makeConstraints { (make) in
            make.top.equalTo(storeButton.snp_top)
            make.width.height.equalTo(storeButton)
            make.leading.equalTo(shareButton.snp_trailing).offset(padding)
        }
        
        label2.snp_makeConstraints { (make) in
            make.width.equalTo(width)
            make.top.equalTo(downButton.snp_bottom)
            make.leading.equalTo(downButton.snp_leading)
        }
        
        delyButton.snp_makeConstraints { (make) in
            make.leading.equalTo(downButton.snp_trailing).offset(padding)
            make.width.height.equalTo(storeButton)
            make.top.equalTo(storeButton.snp_top)
        }
        
        label3.snp_makeConstraints { (make) in
            make.width.equalTo(width)
            make.top.equalTo(delyButton.snp_bottom)
            make.leading.equalTo(delyButton.snp_leading)
        }
        
        shareButton.addTarget(self, action: #selector(shareToWechat(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        downButton.addTarget(self, action: #selector(downVideo), forControlEvents: .TouchUpInside)
        storeButton.addTarget(self, action: #selector(careVideo), forControlEvents: .TouchUpInside)
        delyButton.addTarget(self, action: #selector(commit), forControlEvents: .TouchUpInside)

    }
    
    func setUpGIF() -> Void {
        view.addSubview(gifImageView)
        gifImageView.snp_makeConstraints { (make) in
            make.top.equalTo(delyButton.snp_bottom).offset(20)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(videoViewHeight)
        }
        gifImageView.animateWithImage(named: "mugen.gif")
    }
    
    func setupAnotherVideoView() -> Void {
        
        view.addSubview(antoherViewVideo)
        antoherViewVideo.snp_makeConstraints { (make) in
            make.top.equalTo(delyButton.snp_bottom).offset(20)
            make.leading.equalTo(view)
            make.trailing.equalTo(view)
            make.height.equalTo(videoViewHeight)
        }
        
        let anotherImage = UIImageView()
        let title = UILabel()
        let time = UILabel()
        
        antoherViewVideo.addSubview(anotherImage)
        antoherViewVideo.addSubview(title)
        antoherViewVideo.addSubview(time)
        
        anotherImage.snp_makeConstraints { (make) in
            make.edges.equalTo(antoherViewVideo)
        }
        
        title.snp_makeConstraints { (make) in
            make.center.equalTo(antoherViewVideo.snp_center)
        }
        
        time.snp_makeConstraints { (make) in
            make.bottom.equalTo(antoherViewVideo.snp_bottom).offset(-8)
            make.trailing.equalTo(antoherViewVideo.snp_trailing).offset(-8)
        }
        
        anotherImage.kf_setImageWithURL(NSURL(string: self.anotherVideo.videoImageURL)!, placeholderImage: nil)
        title.text = anotherVideo.videoTitle
        time.text = anotherVideo.videoTime
    }
    
    func setupValue() -> Void {
        videoTitleLabel.text = video.videoTitle
        videoInformationLabel.text = video.videoDescription
        seeNumberLabel.text = video.videoPlayNumber
        timeLabel.text = video.videoTime
        
        storeButton.setImage(UIImage(named: "收藏"), forState: .Normal)
        shareButton.setImage(UIImage(named: "分享"), forState: .Normal)
        downButton.setImage(UIImage(named: "下载"), forState: .Normal)
        delyButton.setImage(UIImage(named: "评论"), forState: .Normal)
    }
//    MARK:下载视频
    /**
     下载视频 , 将下载放在特定的线程中来进行下载
     */
    func downVideo() {
        
        DownVideo.down(video.videoURL) { (down) in
            print(down)
        }
    }
    /**
     收藏视频
     */
    func careVideo() {
        let careVideo = CareVideoItem(videoJSONData: video)
        
        CareVideoItem.save(careVideo) { (res) in
            if res {
                HUD.show(HUDContentType.LabeledSuccess(title: "收藏成功", subtitle: ""))
                HUD.hide(afterDelay: NSTimeInterval(1.5))
            }else {
                HUD.show(HUDContentType.LabeledError(title: "收藏失败", subtitle: "What"))
                HUD.hide(afterDelay: NSTimeInterval(1.5))
            }
        }
    }
    /**
     留言
     */
    func commit()  {
        presentViewController(ComiteViewController(), animated: true) { 
            
        }
        player.pause()
    }
    /**
     分享视频
     
     - parameter button: button
     
     */

    
    func shareToWechat(button:UIButton) -> Void {
        popMenu.showMenuAtView(self.view)
        
    }
    
    //MARK: 分享到 微信 朋友圈
    /**
     分享到 微信 朋友圈
     */
    private func shareWeChat() {

        let account = MonkeyKing.Account.WeChat(appID: Configs.Wechat.appID, appKey: Configs.Wechat.appKey)
        MonkeyKing.registerAccount(account)
        let info = MonkeyKing.Info(
            title: video.videoTitle,
            description: video.videoDescription,
            thumbnail: UIImage(named: ""),
            media: .Video(NSURL(string:video.videoURL)!)
        )
        let message = MonkeyKing.Message.WeChat(.Timeline(info:info))
        MonkeyKing.shareMessage(message) { (result) in
            print("result: \(result)")
        }
        
    }
        /**
         分享到微博
         */
    private func shareWeiBo() {
        
        let account = MonkeyKing.Account.Weibo(appID: Configs.Weibo.appID, appKey: Configs.Weibo.appKey, redirectURL: Configs.Weibo.redirectURL)
        MonkeyKing.registerAccount(account)
        var accesstoken: String?
        if !account.isAppInstalled {
            MonkeyKing.OAuth(.Weibo, completionHandler: { (dic, response, error) in
                if let json = dic, accessToken = json["access_token"] as? String {
                    accesstoken = accessToken
                    print("dictionary\(dic) error \(error)")
                }
            })
        }
        
        let message = MonkeyKing.Message.Weibo(MonkeyKing.Message.WeiboSubtype.Default(info: (
            title: video.videoTitle,
            description: video.videoDescription,
            thumbnail: nil,
            media: MonkeyKing.Media.URL(NSURL(string: video.videoURL)!)),
            accessToken: accesstoken))
        MonkeyKing.shareMessage(message) { (result) in
            print("result:\(result)")
        }
        
    }
    /**
     分享到QQ好友
     */
    private func shareQQ() {
        let account = MonkeyKing.Account.QQ(appID: Configs.QQ.appID)
        MonkeyKing.registerAccount(account)
        let info = MonkeyKing.Info(
        title: video.videoTitle,
        description: video.videoDescription,
        thumbnail: nil,
        media: .Video(NSURL(string:video.videoURL)!))
        let messsage = MonkeyKing.Message.QQ(.Friends(info: info))
        MonkeyKing.shareMessage(messsage) { (result) in
            
        }
    }
    /**
     分享到微信好友
     */
    private func shareQQDataLing() {
        let account = MonkeyKing.Account.WeChat(appID: Configs.Wechat.appID, appKey: Configs.Wechat.appKey)
        MonkeyKing.registerAccount(account)
        let info = MonkeyKing.Info(
            title: video.videoTitle,
            description: video.videoDescription,
            thumbnail: UIImage(named: ""),
            media: .Video(NSURL(string:video.videoURL)!)
        )
        let message = MonkeyKing.Message.WeChat(.Session(info:info))
        MonkeyKing.shareMessage(message) { (result) in
            print("result: \(result)")
        }
    }
    
}







