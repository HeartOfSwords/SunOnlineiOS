//
//  VideosKindsViewController.swift
//  SunGod
//
//  Created by 太阳在线 on 16/5/23.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit
import MJRefresh
import SwiftyJSON
import PKHUD
import Haneke
class VideosKindsViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    private let kindsCellidentifier = "kindsCell"
    private var kinds = [VideosKindsModel]() {
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpNav()
        setUpCollectionView()
        requestCacheData()
    }
}

extension VideosKindsViewController {
    func setUpView() {
        title = "栏目"
    }
    
    func setUpNav() {
        ///添加左上角的侧滑按钮
        addLeftBarButtonWithImage(UIImage(named: leftMenuImageName)!)
    }
    
    func setUpCollectionView() -> Void {
        let layout = UICollectionViewFlowLayout()
        let width = (mainScreen.width - 2) / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        let cellNib = UINib(nibName: "VideoKindsCollectionViewCell", bundle: nil)
        collectionView.registerNib(cellNib, forCellWithReuseIdentifier: kindsCellidentifier)
        collectionView.backgroundColor = UIColor.whiteColor()
        view.addSubview(collectionView)
        
        collectionView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        collectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(pullDownRefresh))
    }
    
    /**
      下拉刷新动作
     */
    func pullDownRefresh() -> Void {
        requestKinds { (res) in
            if res {
                self.collectionView.mj_header.endRefreshing()
            }else {
                HUD.show(HUDContentType.LabeledError(title: "发生错误", subtitle: "原谅我"))
                HUD.hide(afterDelay: NSTimeInterval(1.5))
                self.collectionView.mj_header.endRefreshing()
            }
        }
        
    }
    

    /**
     获取栏目的信息
     
     - parameter back: 是否请求成功
     */
    private func requestKinds(back:(res: Bool) -> Void) -> Void {
        NetWorkingManager.VideosKinds.requestData { (data) in
            guard let data = data else {
                back(res:false)
                return
            }

            self.paseData(data, back: { (res) in
                back(res:res)
            })
            
            /**
             开始缓存数据,在缓存之前先删除之前的缓存
             */
            let cache = Shared.dataCache
            //移除缓存
            cache.remove(key: "SunOnlinekinds")
            //添加缓存
            cache.set(value: data, key: "SunOnlinekinds")
        }
    }
    
    func requestCacheData() -> Void {
        let cache = Shared.dataCache
        cache.fetch(key: "SunOnlinekinds").onSuccess { (data) in
            ///如果有缓存的话就从缓存中直接读取
            ///对缓存中的数据进行解析
            self.paseData(data, back: { (res) in
                
            })

            }
            .onFailure { (error) in
                
                ///如果没有缓存的话从网络中获取,调用 collectionView.mj_header 来进行获取数据
                self.collectionView.mj_header.beginRefreshing()
        }
    }
    
    func paseData(data:NSData,back:(res: Bool) -> Void) -> Void {
        /// 获取到数据之后对数据进行进行解析,转化成对应的模型
        let jsonData = JSON(data:data)["links"]
        /**
         *  对请求回来的JSON 数组进行遍历
         */
        
        var kindArray = [VideosKindsModel]()
        for (_, subJSON) in jsonData {
            let kind = VideosKindsModel(VideoData:subJSON)
            kindArray.append(kind)
            
        }
        
        if kindArray.isEmpty {
            back(res:false)
        }else {
            self.kinds = kindArray
            back(res:true)
        }
    }

}


extension VideosKindsViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cv = VideosKingsListViewController()
        cv.kind = kinds[indexPath.row]
        navigationController?.pushViewController(cv, animated: true)
    }

}

extension VideosKindsViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return kinds.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kindsCellidentifier, forIndexPath: indexPath) as! VideoKindsCollectionViewCell
        let item = kinds[indexPath.row]
        cell.setUpCell(item.name, photoURL: item.imageURL)
        return cell
    }
}
