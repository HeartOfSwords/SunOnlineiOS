//
//  UserSeeCacheViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/26.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit


private let playIdentifier = "videoListItem"

class UserSeeCacheViewController: UIViewController {

    var type = 0
    
    private var videos = [VideoItemModel]()
    private var careVideos = [CareVideoItem]()
    private var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpCollectionView()
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
    
    
    func setUpCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.whiteColor()
        let cellNib = UINib(nibName: "VideoCollectionViewCell", bundle: nil)
        collectionView.registerNib(cellNib, forCellWithReuseIdentifier: playIdentifier)
        view.addSubview(collectionView)
        ///collection View 布局
        collectionView.snp_makeConstraints { (make) in
            make.leading.trailing.bottom.equalTo(view)
            make.top.equalTo(2)
        }
    }
}

extension UserSeeCacheViewController: UICollectionViewDelegate {
    
}

extension UserSeeCacheViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if type == 0 {
            return self.videos.count
        }else if type == 1 {
            return careVideos.count
        }else{
            return self.videos.count
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(playIdentifier, forIndexPath: indexPath) as! VideoCollectionViewCell
        if type == 0 {
            let item = videos[indexPath.row]
            cell.setUpCell(item.videoTime, information: item.videoTitle, photoURL: item.videoImageURL)
        }else if type == 1 {
            let item = careVideos[indexPath.row]
            cell.setUpCell(item.videoTime, information: item.videoTitle, photoURL: item.videoImageURL)
        }else{
            let item = videos[indexPath.row]
            cell.setUpCell(item.videoTime, information: item.videoTitle, photoURL: item.videoImageURL)
        }
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension UserSeeCacheViewController: UICollectionViewDelegateFlowLayout {
    
    
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
