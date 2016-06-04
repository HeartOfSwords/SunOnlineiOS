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
        collectionView.mj_footer = MJRefreshBackStateFooter(refreshingTarget: self, refreshingAction: #selector(pullUpRefresh))
    }
    
    
    func pullDownRefresh() -> Void {
        collectionView.mj_header.endRefreshing()
    }
    
    func pullUpRefresh() -> Void {
        collectionView.mj_footer.endRefreshingWithNoMoreData()
    }
    
    func requestKinds() -> Void {
        NetWorkingManager.VideosKinds.requestData { (data) in
            guard let data = data else {
                return
            }
            /// 获取到数据之后对数据进行进行解析,转化成对应的模型
            let jsonData = JSON(data:data)
            /**
             *  对请求回来的JSON 数组进行遍历
             */
            for (_, subJSON) in jsonData {
                let kind = VideosKindsModel(VideoData:subJSON)
                self.kinds.append(kind)
            }
        }
    }
}


extension VideosKindsViewController: UICollectionViewDelegate {
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let cv = VideosKingsListViewController()
        navigationController?.pushViewController(cv, animated: true)
    }

}

extension VideosKindsViewController: UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(kindsCellidentifier, forIndexPath: indexPath) as! VideoKindsCollectionViewCell
        cell.setUpCell("yangxiaolei", photoURL: "http://7u2j0x.com1.z0.glb.clouddn.com/61b207a9jw1euys0v320ej20zk0bwwg7.jpg")
        return cell
    }
}
