//
//  VideosListCollectionViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/11.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import MJRefresh
import SnapKit
import Haneke
import SwiftyJSON
import SwiftyUserDefaults
import PKHUD
import Alamofire

private let reuseIdentifier1 = "videoListItem"

class VideosKingsListViewController: UIViewController{
    
    private var collectionView: UICollectionView!
    private var videos  = [VideoItemModel]()
    private var requestPage = 1
    
    var kind: VideosKindsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpCollectionView()
        setUpNavigation()
        /// - 从缓存中读取数据
        cacheData()
        
        
    }
}


// MARK: extension
extension VideosKingsListViewController {
    
    func setUpCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.backgroundColor = UIColor.whiteColor()
        let cellNib = UINib(nibName: "VideoCollectionViewCell", bundle: nil)
        collectionView.registerNib(cellNib, forCellWithReuseIdentifier: reuseIdentifier1)
        view.addSubview(collectionView)
        ///collection View 布局
        
        collectionView.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.leading.trailing.bottom.equalTo(view)
        }
        
        //添加下拉刷新
        
        let collectionHeadView = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pullDownLoad))
        collectionHeadView.lastUpdatedTimeLabel.hidden = true
        collectionHeadView.setTitle("下拉刷新", forState: MJRefreshState.Idle)
        collectionHeadView.setTitle("松开立刻刷新", forState: MJRefreshState.Pulling)
        collectionHeadView.setTitle("正在刷新", forState: MJRefreshState.Refreshing)
        collectionView.mj_header = collectionHeadView
        let collectionFootView = MJRefreshBackStateFooter(refreshingTarget: self, refreshingAction: #selector(pullFooter))
        collectionFootView.setTitle("加载更多", forState: MJRefreshState.Idle)
        collectionFootView.setTitle("点击或上拉加载更多", forState: MJRefreshState.Pulling)
        collectionFootView.setTitle("正在加载...", forState: MJRefreshState.Refreshing)
        collectionFootView.setTitle("没有更多数据", forState: MJRefreshState.NoMoreData)
        collectionView.mj_footer = collectionFootView
        
    }
    
    /**
     下啦刷新从网络中获取数据
     */
    func pullDownLoad() -> Void {
        
        /**
         总是从第一页中来获取数据
         */
        requestVideos(1) { (videosData) in
            
            self.requestPage = 1
            guard let data = videosData else {
                /**
                 如果从网络中没有获取到数据，给用户提示错误信息
                 */
                HUD.show(HUDContentType.LabeledError(title: "发生错误", subtitle: "原谅我"))
                HUD.hide(afterDelay: NSTimeInterval(1.5))
                return
            }
            /**
             如果从网络中获取到了信息则对请求到的数据进行解析,同时把获取到的数据进行缓存
             */
            self.paseData(data)
            self.collectionView.mj_header.endRefreshing()
            /**
             开始缓存数据,在缓存之前先删除之前的缓存
             */
            let cache = Shared.dataCache
            //移除缓存
            cache.remove(key: "SunOnlinekindsVideo")
            //添加缓存
            cache.set(value: data, key: "SunOnlinekindsVideo")
        }
        
    }
    
    func pullFooter() -> Void {
        
        collectionView.mj_footer.endRefreshingWithNoMoreData()
    }
    
    func setUpNavigation() {

        //设置返回按钮的文字为空
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
        title = kind.name
    }
    

    /**
     从网络中获取请求
     
     - parameter page: 获取第几页的数据
     - parameter back: 返回获取到的结果
     */
    func requestVideos(page: Int , back: (videosData: NSData?) -> Void) {
        /**
         *  通过网络获取视频
         */
        Alamofire.request(.GET, kind.allVideosURL).responseJSON { (res) in
            
            guard let data = res.data else {
                back(videosData: nil)
                return
            }
            let jsonData = JSON(data:data)["links"]
            
            let ref = baseURL + jsonData[0,"href"].stringValue
            
            Alamofire.request(.GET, ref).responseJSON(completionHandler: { (res) in
                back(videosData: res.data)
            })
            
        }
    }
    /**
     从缓存中读取数据,仅仅缓存第一页的数据
     */
    func cacheData() -> Void {
        let cache = Shared.dataCache
        cache.fetch(key: "SunOnlinekindsVideo").onSuccess { (data) in
            ///如果有缓存的话就从缓存中直接读取
            ///对缓存中的数据进行解析
            self.paseData(data)
            }
            .onFailure { (error) in
               
                ///如果没有缓存的话从网络中获取,调用 collectionView.mj_header 来进行获取数据
                self.collectionView.mj_header.beginRefreshing()
        }
    }
    /**
     对数据进行解析
     
     - parameter data: 数据源
     */
    func paseData(data:NSData) -> Void {
        let jsonData = JSON(data:data)
        
        guard jsonData != nil else {
            HUD.show(HUDContentType.LabeledError(title: "发生错误", subtitle: "原谅我"))
            HUD.hide(afterDelay: NSTimeInterval(1.5))
            return
        }
        
        var requestVideos = [VideoItemModel]()
        for (_,subJSON) in jsonData {
            let oneVideo = VideoItemModel(videoJSONData: subJSON)
            requestVideos.append(oneVideo)
        }
        
        if requestVideos.isEmpty {
            HUD.show(HUDContentType.LabeledError(title: "发生错误", subtitle: "原谅我"))
            HUD.hide(afterDelay: NSTimeInterval(1.5))
        }else{
            /**
             把第一次获取到的数据赋值给 页面的数据源
             */
            if requestPage == 1 {
                self.videos = requestVideos
                self.collectionView.reloadData()
            }else {
                self.videos.appendContentsOf(requestVideos)
                self.collectionView.reloadData()
            }
            
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension VideosKingsListViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        /**
         collection item 的大小
         
         - parameter width:  宽度为屏幕宽度
         - parameter height: 高度为屏幕的 9 ／16
         
         - returns: 返回size
         */
        return CGSize(width:view.frame.width, height: (view.frame.width) * (9.0 / 16))
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 2
    }
}

// MARK: UICollectionViewDataSource
extension VideosKingsListViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier1, forIndexPath: indexPath) as! VideoCollectionViewCell
        let item = videos[indexPath.row]
        cell.setUpCell(item.videoTime, information: item.videoTitle, photoURL: item.videoImageURL)
  
        return cell
        
    }
}

// MARK: UICollectionViewDelegate
extension VideosKingsListViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        /// 选中 cell 之后进行跳转
        ///在选中 cell 之后对网络状态进行判断 符合用户设置的 话可以进行跳转
        func presentView() {
            let videoItem = VideoItemInformationViewController()
            let item = videos[indexPath.row]
            videoItem.video = item
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




