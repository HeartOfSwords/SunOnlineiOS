//
//  UserSeeCacheViewController.swift
//  SunGod
//
//  Created by xiaolei on 16/5/26.
//  Copyright © 2016年 太阳在线. All rights reserved.
//

import UIKit


private let playIdentifier = "play"

class UserSeeCacheViewController: UIViewController {

    
    var type = 0
    var videos = [VideoItemModel]()
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
        default:
            title = "播放记录"
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
            make.leading.top.trailing.bottom.equalTo(view)
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
        return videos.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(playIdentifier, forIndexPath: indexPath) as! VideoCollectionViewCell
        return cell
    }
}
