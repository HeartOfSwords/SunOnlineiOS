//
//  UserSeeCacheViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/26.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import Alamofire
import PKHUD
import SwiftyUserDefaults
import SnapKit


private let tableCellID = "VideotableviewcellItem"
class UserSeeCacheViewController: UIViewController {

    var type = 0
    
    private var videos = [VideoItemModel]()
    private var careVideos = [CareVideoItem]()
    private var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpTableView()
        DownVideo.share.downVideoRequest.progress { (bytesRead, totalBytesRead, totalBytesExpectedToRead) in
                        let percent = totalBytesRead * 100 / totalBytesExpectedToRead
                        print("已经下载 : \(totalBytesRead) 当前进度 \(percent) %")
                }

    }
    
    
}

// MARK: Function
extension UserSeeCacheViewController {
   private func setUpView() {
    view.backgroundColor = UIColor.whiteColor()
    
        switch type {
        case 0:
            title = "离线缓存"
        case 1:
            title = "我的收藏"
            careVideos = CareVideoItem.select()
        default:
            title = "播放记录"
            videos = VideoItemModel.selectVideoItemModel()
        }
    }
    
    func setUpTableView() -> Void {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .None
        let cellNib = UINib(nibName: "VideoItemTableViewCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: tableCellID)
        view.addSubview(tableView)
        tableView.snp_makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }

    
}


extension UserSeeCacheViewController: UITableViewDelegate {
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return mainScreen.size.width * (9.0 / 16.0)
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /// 选中 cell 之后进行跳转
        ///在选中 cell 之后对网络状态进行判断 符合用户设置的 话可以进行跳转
        let videoItem = VideoItemInformationViewController()
        func presentView() {
            if type == 0 {
                
                let item = videos[indexPath.row]
                videoItem.video = item
            }else if type == 1 {
                let item = careVideos[indexPath.row]
                let item2 = VideoItemModel(videoJSONData: item)
                
                videoItem.video = item2
            }else{
                let item = videos[indexPath.row]
                videoItem.video = item
            }
            
            presentViewController(videoItem, animated: true) {
                
            }
        }
        let net = NetworkReachabilityManager()
        net?.startListening()
        net?.listener = {
            state in
            switch state {
            case .Reachable(let net):
                //有网
                if net == .EthernetOrWiFi {
                    //Wi-Fi下进行跳转
                    presentView()
                }else {
                    
                    if Defaults[.allowSee] {
                        //如果用户开启了 运营商网络观看视频的话直接跳转
                        presentView()
                    }else {
                        HUD.show(HUDContentType.LabeledSuccess(title: "你在使用WWAN网络", subtitle: "在设置中开启WWAN网络观看视频"))
                        HUD.hide(afterDelay: NSTimeInterval(1))
                    }
                }
                
            case .Unknown:
                HUD.show(HUDContentType.LabeledSuccess(title: "好厉害的网络", subtitle: "你用的什么网络呀"))
                HUD.hide(afterDelay: NSTimeInterval(1))
            case .NotReachable:
                //没有网络
                HUD.show(HUDContentType.LabeledError(title: "没有网络", subtitle: "亲,该交话费了"))
                HUD.hide(afterDelay: NSTimeInterval(1.5))
            }
        }
    }
}

extension UserSeeCacheViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if editingStyle == .Delete {
            //删除
            switch type {
            case 0:
//                title = "离线缓存"
                let item = videos[indexPath.row]
                VideoItemModel.deleteVideoItemModel(item.videoID, back: { (res) in
                    
                })
            case 1:
//                title = "我的收藏"
                let item = careVideos[indexPath.row]
                CareVideoItem.delete(item.videoID, back: { (res) in
                    if res {
                        self.careVideos.removeAtIndex(indexPath.row)
                        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
                    }
                })
            default:
//                title = "播放记录"
                let item = videos[indexPath.row]
                VideoItemModel.deleteVideoItemModel(item.videoID, back: { (res) in
                    if res {
                        
                        self.videos.removeAtIndex(indexPath.row)
                        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
                    }
                })
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if type == 0 {
            return self.videos.count
        }else if type == 1 {
            return careVideos.count
        }else{
            return self.videos.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(tableCellID, forIndexPath: indexPath) as! VideoItemTableViewCell
        if type == 0 {
            //离线缓存
            let item = videos[indexPath.row]
            cell.setUpCell(item.videoTime, information: item.videoTitle, photoURL: item.videoImageURL)
        }else if type == 1 {
            //我的收藏
            let item = careVideos[indexPath.row]
            cell.setUpCell(item.videoTime, information: item.videoTitle, photoURL: item.videoImageURL)
        }else{
            //播放记录
            let item = videos[indexPath.row]
            cell.setUpCell(item.videoTime, information: item.videoTitle, photoURL: item.videoImageURL)
        }
        return cell
    }
}


