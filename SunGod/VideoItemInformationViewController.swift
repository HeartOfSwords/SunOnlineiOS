//
//  VideoItemInformationViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/11.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import Kingfisher


private let commitCellIdentifier = "commitCell"
private let videoCellIdentifier = "videoCell"

class VideoItemInformationViewController: UIViewController {

    private let videoPhoto = UIImageView()
    private let videoTitleLabel = UILabel()
    private let videoInformationLabel = UILabel()
    private let videoCommitTableView = UITableView()
}

//MRAK: Function
extension VideoItemInformationViewController {
    
    func setUpView() {
        view.addSubview(videoPhoto)
        videoPhoto.snp_makeConstraints { (make) in
            make.trailing.leading.equalTo(self.view)
            make.top.equalTo(self.view).offset(74)
            make.height.equalTo(videoViewHeight)
        }
        videoPhoto.kf_setImageWithURL(NSURL(string: "http://7u2j0x.com1.z0.glb.clouddn.com/61b207a9jw1euys0v320ej20zk0bwwg7.jpg")!)
    }
        

}


//MARK: Override
extension VideoItemInformationViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        setUpView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
//        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: false)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//        UIApplication.sharedApplication().setStatusBarStyle(.LightContent, animated: false)
    }
    
}




