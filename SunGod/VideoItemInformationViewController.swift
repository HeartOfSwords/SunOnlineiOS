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

    }
    
    func setUpLabel() -> Void {
        view.addSubview(videoTitleLabel)
        view.addSubview(videoInformationLabel)
        
        videoTitleLabel.snp_makeConstraints { (make) in
            make.top.equalTo(player.snp_bottom).offset(2)
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




