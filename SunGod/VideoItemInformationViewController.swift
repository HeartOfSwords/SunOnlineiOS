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

private let commitCellIdentifier = "commitCell"
private let videoCellIdentifier = "videoCell"

class VideoItemInformationViewController: UIViewController {

    private lazy var player:BMPlayer = BMPlayer()
    private let videoPhoto = UIImageView()
    private let videoTitleLabel = UILabel()
    private let videoInformationLabel = UILabel()
    private let videoCommitTableView = UITableView()
}

//MRAK: Function
extension VideoItemInformationViewController {
    
    
    func setUpNav() {

    }
    
    func setUpVideoPlayer() {
        view.addSubview(player)
        player.snp_makeConstraints { (make) in
            make.trailing.leading.equalTo(self.view)
            make.top.equalTo(self.view)
            make.height.equalTo(self.view.snp_width).multipliedBy(9.0 / 16.0)
        }
        player.backBlock =  { [unowned self] in
            self.dismissViewControllerAnimated(true, completion: { 
                
            })
        }
        
        player.playWithURL(NSURL(string: "http://7s1rp2.com1.z0.glb.clouddn.com/1%E3%80%81HTML5%E9%9F%B3%E9%A2%91%E6%92%AD%E6%94%BE.mp4")!)
        player.play()

    }
    
    func setUpView() {
        player.addSubview(videoPhoto)
        videoPhoto.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(playVideo(_:))))
        videoPhoto.snp_makeConstraints { (make) in
            make.edges.equalTo(self.player)
        }
        videoPhoto.kf_setImageWithURL(NSURL(string: "http://7u2j0x.com1.z0.glb.clouddn.com/61b207a9jw1euys0v320ej20zk0bwwg7.jpg")!)
    }
    
    func playVideo(tap: UITapGestureRecognizer) {
        videoPhoto.alpha = 0

        print("sss")
    }
    

}


//MARK: Override
extension VideoItemInformationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setUpVideoPlayer()
//        setUpView()
        setUpNav()
    }
    //隐藏 StatusBar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
}




